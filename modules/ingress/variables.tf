variable "module_depends_on" {
  default = []
}

variable "bitnami_external_dns_version" {
  type        = string
  description = "External DNS Version"
}

variable "stable_nginx_ingress_version" {
  type        = string
  description = "Nginx Ingress Version"
}

variable "jetstack_cert_manager_version" {
  type        = string
  description = "Jetstack Cert Manager Version"
}

variable "stable_metrics_server_version" {
  type        = string
  description = "Metrics Server Version"
}

variable "cert_manager_email" {
  type        = string
  description = "Set email for Cert manager notifications"
}

variable "domain" {
  type    = string
  description = "Domain name for Extarnal DNS service"
}