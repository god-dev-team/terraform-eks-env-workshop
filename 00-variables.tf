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

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.40.0.0/16"
}

variable "availability_zones" {
  description = "A list of availability zones in which to create subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "public_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type        = list(string)
  default     = ["10.40.10.0/24", "10.40.11.0/24", "10.40.12.0/24"]
}


variable "private_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type        = list(string)
  default     = ["10.40.50.0/24", "10.40.51.0/24", "10.40.52.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
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
