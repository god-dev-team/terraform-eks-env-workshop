# jenkins

resource "helm_release" "jenkins" {
  count = var.jenkins_count ? 1 : 0
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "jenkins"
  version    = var.jenkins_version

  namespace = "jenkins"
  name      = "jenkins"

  values = [
    file("./modules/jenkins/values/jenkins.yaml")
  ]

  wait = false

  create_namespace = true

  depends_on = [
    var.module_depends_on
  ]
}

resource "kubernetes_cluster_role_binding" "cluster-admin-jenkins-default" {
  count = var.jenkins_count ? 1 : 0
  metadata {
    name = "cluster-admin:jenkins:default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    namespace = "jenkins"
    name      = "default"
  }

  depends_on = [
    var.module_depends_on
  ]
}

# for jenkins
resource "kubernetes_config_map" "jenkins-env" {
  count = var.jenkins_count ? 1 : 0
  metadata {
    namespace = "default"
    name      = "jenkins-env"
  }

  data = {
    "groovy" = file("./modules/jenkins/values/env/jenkins-env.groovy")
  }
}