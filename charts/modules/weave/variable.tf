variable "module_depends_on" {
  default = []
}

variable "stable_weave_scope_version" {
  type        = string
  description = "Weave Scope Version"
}

variable "gabibbo97_keycloak_gatekeeper_version" {
  type        = string
  description = "Keycloak Gatekeeper Version"
}