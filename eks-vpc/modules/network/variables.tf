variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster."
}

variable "availability_zones" {
  description = "A list of availability zones in which to create subnets"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type        = list(string)
}


variable "private_subnets_cidr" {
  description = "subnet cidr details defined for private n/w"
  type        = list(string)
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
}