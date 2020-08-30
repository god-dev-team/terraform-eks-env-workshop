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

  dynamic "set" {
    for_each = var.domains
    content {
      name  = "keycloak.ingress.hosts[${set.key}]"
      value = "keycloak.${set.value}"
    }
  }

  dynamic "set" {
    for_each = var.domains
    content {
      name  = "keycloak.ingress.tls[${set.key}].hosts[0]"
      value = "keycloak.${set.value}"
    }
  }

  depends_on = [
    kubernetes_secret.keycloak-realm,
    var.module_depends_on
  ]
}