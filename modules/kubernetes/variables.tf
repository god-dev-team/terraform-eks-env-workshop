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
  type        = string
  description = "EC2 Instance type"
}

variable "spot_price" {
  type    = string
  default = "0.5"
}

variable "admin_arns" {
  type        = list(map(string))
  description = "ARNs of users which would have admin permissions."
  default     = []
}

variable "domain" {
  type    = string
  description = "Domain name for Extarnal DNS service"
  default = "set_domain"
}

### k8s admins

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  
  default = [
    {
      userarn   = "arn:aws:iam::249565476171:user/tgaleev"
      username  = "tgaleev"
      groups    = ["system:masters"]
    },
  ]
}
