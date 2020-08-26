resource "helm_release" "nginx-ingress" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "nginx-ingress"
  version    = var.stable_nginx_ingress_version

  namespace = "kube-ingress"
  name      = "nginx-ingress"

  values = [
    file("./modules/ingress/values/ingress-nginx.yml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    var.module_depends_on
  ]
}

### Cert manager

resource "helm_release" "cert-manager-issuers" {
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "raw"

  namespace = "cert-manager"
  name      = "cert-manager-issuers"

  values = [
    file("./modules/ingress/values/cert-manager-issuers.yml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    helm_release.cert-manager,
  ]
}

resource "helm_release" "cert-manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.jetstack_cert_manager_version

  namespace = "cert-manager"
  name      = "cert-manager"

  values = [
    file("./modules/ingress/values/cert-manager.yml")
  ]

  create_namespace = true
}

### External-DNS

resource "helm_release" "external-dns" {
  
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = var.bitnami_external_dns_version

  namespace = "kube-ingress"
  name      = "external-dns"

  values = [
    file("./modules/ingress/values/external-dns.yml")
  ]

  set {
    name  = "domainFilters[0]"
    value = var.domain
  }

  wait = false

  create_namespace = true
}

### Metrics server

resource "helm_release" "metrics-server" {
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "metrics-server"
  version    = var.stable_metrics_server_version

  namespace = "kube-system"
  name      = "metrics-server"

  values = [
    file("./modules/ingress/values/metrics-server.yml")
  ]

  wait = false
}