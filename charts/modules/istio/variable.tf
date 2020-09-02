variable "module_depends_on" {
  default = []
}

variable "gabibbo97_keycloak_gatekeeper_version" {
  type        = string
  description = "Keycloak Gatekeeper Version"
}

variable "kiali_gatekeeper_count" {
  default = []
}

variable "tracing_gatekeeper_count" {
  default = []
}