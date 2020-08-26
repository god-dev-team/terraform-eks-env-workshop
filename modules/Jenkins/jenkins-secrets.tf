# jenkins secret

# https://github.com/jenkinsci/kubernetes-credentials-provider-plugin/tree/master/docs/examples

resource "kubernetes_secret" "jenkins-secret-username" {
  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-username"

    labels = {
      "jenkins.io/credentials-type" : "usernamePassword"
    }

    annotations = {
      "jenkins.io/credentials-description" : "credentials from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "username" = "username"
    "password" = "password"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-text" {
  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-text"

    labels = {
      "jenkins.io/credentials-type" : "secretText"
    }

    annotations = {
      "jenkins.io/credentials-description" : "secret text credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "text" = "Hello World!"
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-file" {
  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-file"

    labels = {
      "jenkins.io/credentials-type" : "secretFile"
    }

    annotations = {
      "jenkins.io/credentials-description" : "secret file credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "filename" = "secret.txt"
    "data"     = file("./modules/jenkins/values/secret/secret.txt")
  }

  depends_on = [
    helm_release.jenkins,
  ]
}

resource "kubernetes_secret" "jenkins-secret-private-key" {
  metadata {
    namespace = "jenkins"
    name      = "jenkins-secret-private-key"

    labels = {
      "jenkins.io/credentials-type" : "basicSSHUserPrivateKey"
    }

    annotations = {
      "jenkins.io/credentials-description" : "basic user private key credential from Kubernetes"
    }
  }

  type = "Opaque"

  data = {
    "username"   = "jenkins"
    "privateKey" = file("./modules/jenkins/values/secret/jenkins.txt")
  }

  depends_on = [
    helm_release.jenkins,
  ]
}