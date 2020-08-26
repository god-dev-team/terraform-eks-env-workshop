resource "helm_release" "chartmuseum" {
  count = var.chartmuseum_count ? 1 : 0
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "chartmuseum"
  version    = var.stable_chartmuseum_version

  namespace = "repository"
  name      = "chartmuseum"

  values = [
    file("./modules/repository/values/chartmuseum.yaml")
  ]

  wait = false

  create_namespace = true
}

resource "helm_release" "archiva" {
  count = var.archiva_version ? 1 : 0
  repository = "https://xetus-oss.github.io/helm-charts/"
  chart      = "xetusoss-archiva"

  namespace = "repository"
  name      = "archiva"

  values = [
    file("./modules/repository/values/archiva.yaml")
  ]

  wait = false

  create_namespace = true

}

resource "helm_release" "sonatype-nexus" {
  count = var.nexus_count ? 1 : 0
  repository = "https://oteemo.github.io/charts"
  chart      = "sonatype-nexus"
  version    = var.oteemo_sonatype_nexus_version

  namespace = "repository"
  name      = "sonatype-nexus"

  values = [
    file("./modules/repository/values/sonatype-nexus.yaml")
  ]


  wait = false

}