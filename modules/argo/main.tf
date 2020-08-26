resource "helm_release" "argo" {
  count = var.argo_count ? 1 : 0
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo"
  version    = var.argo_argo_version

  namespace = "argo"
  name      = "argo"

  values = [
    file("./modules/argo/values/argo.yaml")
  ]

  set {
    name  = "server.ingress.enabled"
    value = var.argo_count ? false : true
  }

  set {
    name  = "artifactRepository.s3.region"
    value = var.aws_region
  }

  create_namespace = true

  depends_on = [
    var.module_depends_on
  ]
}

# resource "helm_release" "argo-events" {
#   count = var.argo_count ? 1 : 0
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-events"
#   version    = var.argo_argo_events_version

#   namespace = "argo-events"
#   name      = "argo-events"

#   values = [
#     file("./modules/argo/values/argo-events.yaml")
#   ]

#   wait = false

#   create_namespace = true
# }

resource "helm_release" "argo-gatekeeper" {
  count = var.argo_count ? 1 : 0

  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = var.gabibbo97_keycloak_gatekeeper_version

  namespace = "argo"
  name      = "argo-gatekeeper"

  values = [
    file("./modules/argo/values/argo-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.argo,
    var.module_depends_on
  ]
}

resource "kubernetes_cluster_role_binding" "admin-argo-default" {
  count = var.argo_count ? 1 : 0
  metadata {
    name = "admin:argo:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "argo"
    name      = "default"
  }

  depends_on = [
    helm_release.argo,
  ]
}

resource "kubernetes_cluster_role_binding" "edit-default-default" {
  count = var.argo_count ? 1 : 0
  metadata {
    name = "edit:default:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "default"
    name      = "default"
  }
}

# argo-cd & argo-rollouts

resource "helm_release" "argo-rollouts" {
  count = var.argo_count ? 1 : 0
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = var.argo_argo_rollouts_version

  namespace = "argo-rollouts"
  name      = "argo-rollouts"

  values = [
    file("./modules/argo/values/argo-rollouts.yaml")
  ]

  create_namespace = true
}

resource "helm_release" "argo-cd" {
  count = var.argo_count ? 1 : 0
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_argo_cd_version

  namespace = "argo-cd"
  name      = "argocd"

  values = [
    file("./modules/argo/values/argo-cd.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    var.module_depends_on,
    helm_release.argo-rollouts,
  ]
}

