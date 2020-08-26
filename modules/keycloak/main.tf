# keycloak

resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = "keycloak"
  }
}

resource "kubernetes_secret" "keycloak-realm" {
  metadata {
    namespace = "keycloak"
    name      = "realm-demo-secret"
  }

  type = "Opaque"

  data = {
    "demo.json" = file("./modules/keycloak/values/realm/demo.json")
  }

  depends_on = [
    kubernetes_namespace.keycloak,
  ]
}

resource "helm_release" "keycloak" {
  repository = "https://codecentric.github.io/helm-charts"
  chart      = "keycloak"
  version    = var.codecentric_keycloak_version

  namespace = "keycloak"
  name      = "keycloak"

  values = [
    file("./modules/keycloak/values/keycloak.yaml")
  ]

  depends_on = [
    kubernetes_secret.keycloak-realm,
    var.module_depends_on
  ]
}