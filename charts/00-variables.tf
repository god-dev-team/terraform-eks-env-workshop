variable "aws_region" {
  description = "Name the aws region (eu-central-1, us-central-1 and etc.)"
  default     = "eu-central-1"
}

variable "cert_manager_email" {
  type        = string
  description = "Email to cert-manager"
  default     = "timur.galeev@god.de"
}

variable "domains" {
  type        = string
  description = "domain name for ingress"
  default     = "godapp.de"
}
