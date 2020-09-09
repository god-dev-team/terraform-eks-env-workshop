variable "module_depends_on" {
  default = []
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster."
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "private_subnets" {
  type        = list
  description = "vpc private subnets"
}

variable "max_cluster_size" {
  type        = string
  description = "Number of max instances."
}

variable "desired_capacity" {
  type        = string
  description = "Number of desired instances."
}

variable "min_cluster_size" {
  type        = string
  description = "Number of min instances."
}

variable "cluster_version" {
  type        = string
  description = "Number of desired instances."
}

variable "instance_type" {
  type        = list(string)
  description = "Worker EC2 Instance type"
}

variable "instance_pools" {
  type        = string
  description = "Number EC2 Instance type"
}

variable "instance_price" {
  type    = string
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)
}