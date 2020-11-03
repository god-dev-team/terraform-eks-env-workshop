# monitor

resource "helm_release" "grafana" {
  repository = "https://charts.helm.sh/stable"
  chart      = "grafana"
  version    = var.stable_grafana_version

  namespace = "monitor"
  name      = "grafana"

  values = [
    file("./modules/monitoring/values/grafana.yaml")
  ]

  wait = false

  create_namespace = true

}

resource "helm_release" "prometheus-adapter" {
  repository = "https://charts.helm.sh/stable"
  chart      = "prometheus-adapter"
  version    = var.stable_prometheus_adapter_version

  namespace = "monitor"
  name      = "prometheus-adapter"

  values = [
    file("./modules/monitoring/values/prometheus-adapter.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "prometheus-operator" {
  repository = "https://charts.helm.sh/stable"
  chart      = "prometheus-operator"
  version    = var.stable_prometheus_operator_version

  namespace = "monitor"
  name      = "prometheus-operator"

  values = [
    file("./modules/monitoring/values/prometheus-operator.yaml")
  ]

  create_namespace = true

}

resource "helm_release" "prometheus-alert-rules" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "monitor"
  name      = "prometheus-alert-rules"

  values = [
    file("./modules/monitoring/values/prometheus-alert-rules.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.prometheus-operator,
  ]
}