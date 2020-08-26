variable "domain" {
  type    = string
  description = "Domain name for Extarnal DNS service"
  default = "set_domain"
}

variable "stable_grafana_version" {
  type        = string
  description = "Grafana Version"
}

variable "stable_prometheus_adapter_version" {
  type        = string
  description = "Prometheus Adapter Version"
}

variable "stable_prometheus_operator_version" {
  type        = string
  description = "Prometheus Operator Version"
}