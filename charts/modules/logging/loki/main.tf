#Loki chart repo
resource "helm_release" "loki-stack" {

  name       = "loki"
  repository = "https://grafana.github.io/loki/charts"
  chart      = "loki-stack"
  version    = "0.38.0"
  namespace  = "monitor"

  wait = false

  create_namespace = true

  values = [
    file("./modules/logging/loki/values/loki-stack.yaml"),
  ]

  depends_on = [
    var.module_depends_on
  ]

} 