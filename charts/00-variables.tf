variable "aws_region" {
  description = "Name the aws region (eu-central-1, us-central-1 and etc.)"
  default     = "eu-central-1"
}

variable "cert_manager_email" {
  type        = string
  description = "Email to cert-manager"
  default     = ""
}

variable "domains" {
  type        = string
  description = "domain name for ingress"
  default     = ""
}

######### Charts

variable "jenkins_enabled" {
  default = false
}

variable "chartmuseum_enabled" {
  default = false
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