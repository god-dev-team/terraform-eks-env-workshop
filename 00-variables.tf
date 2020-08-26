variable "environment" {
  type        = string
  description = "Environment"
  default     = "demo"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster"
  default     = "EKS-DEMO"
}

variable "aws_region" {
  description = "Name the aws region (eu-central-1, us-central-1 and etc.)"
  default     = "eu-central-1"
}

variable "network_id" {
  description = "Number would be used to template CIDR 10.X.0.0/16."
  default     = "40"
}

variable "spot_max_cluster_size" {
  type        = string
  description = "Number of max instances."
  default     = "4"
}

variable "spot_min_cluster_size" {
  type        = string
  description = "Number of max instances."
  default     = "3"
}

variable "spot_desired_capacity" {
  type        = string
  description = "Number of desired instances."
  default     = "3"
}

variable "cluster_version" {
  type        = string
  description = "Number of desired instances."
  default     = "1.17"
}

variable "spot_instance_type" {
  type        = string
  description = "EC2 Instance type"
  default     = "m5.large"
}

variable "cert_manager_email" {
  type        = string
  description = "Email to cert-manager"
  default     = "timur.galeev@god.de"
}

variable "domains" {
  description = "domains name for ingress"
  default     = "godapp.de"
}
