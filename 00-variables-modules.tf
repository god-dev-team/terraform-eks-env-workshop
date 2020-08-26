variable "jenkins_enabled" {
  default = true
}

variable "chartmuseum_enabled" {
  default = true
}

variable "archiva_enabled" {
  default = false
}

variable "nexus_enabled" {
  default = false
}

variable "sonarqube_enabled" {
  default = false
}

variable "kiali_gatekeeper_enabled" {
  default = false
}

variable "tracing_gatekeeper_enabled" {
  default = false
}

variable "argo_enabled" {
  default = false
}