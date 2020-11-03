module "iam_assumable_role_admin" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "~> v2.6.0"
  create_role                   = true
  role_name                     = "cluster-autoscaler"
  provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.cluster_autoscaler.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:cluster-autoscaler-aws-cluster-autoscaler"]

  tags = {
    Owner           = split("/", data.aws_caller_identity.current.arn)[1]
    AutoTag_Creator = data.aws_caller_identity.current.arn
    Project         = "${var.cluster_name}project"
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  name_prefix = "cluster-autoscaler"
  description = "EKS cluster-autoscaler policy for cluster ${module.eks.cluster_id}"
  policy      = data.aws_iam_policy_document.cluster_autoscaler.json
}

data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    sid    = "clusterAutoscalerAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "clusterAutoscalerOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${module.eks.cluster_id}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}

resource "helm_release" "cluster-autoscaler" {

  repository = "https://charts.helm.sh/stable"
  chart      = "cluster-autoscaler"
  version    = "7.3.4"

  namespace = "kube-system"
  name      = "cluster-autoscaler"

  # values = [
  #   file("./modules/kubernetes/values/cluster-autoscaler.yaml")
  # ]

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "cloud-provider"
    value = "aws"
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "autoDiscovery.enabled"
    value = true
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role_admin.this_iam_role_arn
  }

  wait = false

  depends_on = [
  ]
}

resource "helm_release" "k8s-spot-termination-handler" {
  repository = "https://charts.helm.sh/stable"
  chart      = "k8s-spot-termination-handler"
  version    = "1.4.9"

  namespace = "kube-system"
  name      = "k8s-spot-termination-handler"

  values = [
    file("./modules/kubernetes/values/k8s-spot-termination-handler.yaml")
  ]

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role_admin.this_iam_role_arn
  }

  wait = false
}