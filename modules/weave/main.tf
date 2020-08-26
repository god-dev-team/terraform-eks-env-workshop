# weave-scope

resource "helm_release" "weave-scope" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "weave-scope"
  version    = var.stable_weave_scope_version

  namespace = "weave"
  name      = "weave-scope"

  values = [
    file("./modules/weave/values/weave-scope.yaml")
  ]

  create_namespace = true
}

resource "helm_release" "weave-scope-gatekeeper" {
  repository = "https://gabibbo97.github.io/charts/"
  chart      = "keycloak-gatekeeper"
  version    = var.gabibbo97_keycloak_gatekeeper_version

  namespace = "weave"
  name      = "weave-scope-gatekeeper"

  values = [
    file("./modules/weave/values/weave-scope-gatekeeper.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.weave-scope,
    var.module_depends_on
  ]
}