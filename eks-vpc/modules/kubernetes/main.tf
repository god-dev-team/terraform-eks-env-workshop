module "eks" {

  source          = "terraform-aws-modules/eks/aws"
  version         = "12.1.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id
  enable_irsa     = true

  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts

  # cluster_endpoint_private_access = true
  # cluster_endpoint_public_access  = false
  cluster_log_retention_in_days = 30
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  write_kubeconfig = true
  manage_aws_auth  = true
  # config_output_path     = "./kube/config"

  tags = {
    Owner           = split("/", data.aws_caller_identity.current.arn)[1]
    AutoTag_Creator = data.aws_caller_identity.current.arn
  }

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  # worker_groups = [
  #   {
  #     spot_price           = var.spot_price
  #     instance_type        = "var.instance_type"
  #     asg_max_size         = var.max_cluster_size
  #     asg_desired_capacity = var.desired_capacity
  #     asg_min_size         = var.min_cluster_size
  #     suspended_processes  = ["AZRebalance"]

  #     kubelet_extra_args  = "--node-labels=node.kubernetes.io/lifecycle=spot"

  #     tags = [
  #         {
  #             "key"                 = "k8s.io/cluster-autoscaler/enabled"
  #             "propagate_at_launch" = "false"
  #             "value"               = "true"
  #         },
  #         {
  #             "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
  #             "propagate_at_launch" = "false"
  #             "value"               = "true"
  #         }
  #     ]
  #   },
  # ]

  worker_groups = [
    {
      name                 = "core"
      asg_max_size         = 1
      asg_min_size         = 1
      asg_desired_capacity = 1
      instance_type        = "t3a.medium"
      subnets              = [var.private_subnets[0]]

      # Use this to set labels / taints
      kubelet_extra_args = "--node-labels=node-role.kubernetes.io/core=core"

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]
    }
  ]

  worker_groups_launch_template = [
    {
      name                    = "worker-spot"
      override_instance_types = ["r5.2xlarge", "r4.2xlarge"]
      spot_instance_pools     = 2
      asg_max_size            = 5
      asg_min_size            = 0
      asg_desired_capacity    = 0

      # Use this to set labels / taints
      kubelet_extra_args = "--node-labels node-role.kubernetes.io/worker=worker,k8s.dask.org/node-purpose=worker --register-with-taints k8s.dask.org/dedicated=worker:NoSchedule"

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/node-template/label/k8s.dask.org/node-purpose"
          "propagate_at_launch" = "false"
          "value"               = "worker"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/node-template/taint/k8s.dask.org/dedicated"
          "propagate_at_launch" = "false"
          "value"               = "worker:NoSchedule"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]
    }
  ]
}

# This makes it possible to use helm later in the installation.
resource "null_resource" "kubectl_config_provisioner" {
  depends_on = [module.eks]
  triggers = {
    kubectl_config = module.eks.kubeconfig
  }
  provisioner "local-exec" {
    command = <<EOT
    aws eks --region ${var.aws_region} wait cluster-active --name ${var.cluster_name}
    aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}
    EOT
  }
}