resource "helm_release" "sonarqube" {
  count = var.sonarqube_count ? 1 : 0
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"
  version    = var.sonarqube_version

  namespace = "repository"
  name      = "sonarqube"

  values = [
    file("./modules/sonarqube/values/sonarqube.yaml")
  ]

  wait = false

}