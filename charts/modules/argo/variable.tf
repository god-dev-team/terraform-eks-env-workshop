variable "module_depends_on" {
  default = []
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "argo_argo_version" {
  type        = string
  description = "Argo Version"
}

variable "argo_argo_events_version" {
  type        = string
  description = "Argo Events Version"
}

variable "gabibbo97_keycloak_gatekeeper_version" {
  type        = string
  description = "Keycloak Gatekeeper Version"
}

variable "argo_argo_rollouts_version" {
  type        = string
  description = "Argo Rollouts Version"
}

variable "argo_argo_cd_version" {
  type        = string
  description = "Argo CD Version"
}

variable "argo_count" {
  default = []
}