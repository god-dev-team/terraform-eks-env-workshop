variable "environment" {
  type        = string
  description = "Environment"
  default     = "GOD-EKS"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster"
  default     = "GOD-EKS"
}

variable "aws_region" {
  description = "Name the aws region (eu-central-1, us-central-1 and etc.)"
  default     = "eu-central-1"
}

################ VPC

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

################ EKS

variable "spot_max_cluster_size" {
  type        = string
  description = "Number of max instances."
  default     = "5"
}

variable "spot_min_cluster_size" {
  type        = string
  description = "Number of max instances."
  default     = "1"
}

variable "spot_desired_capacity" {
  type        = string
  description = "Number of desired instances."
  default     = "1"
}

variable "cluster_version" {
  type        = string
  description = "Number of desired instances."
  default     = "1.17"
}

variable "spot_instance_type" {
  type        = list(string)
  description = "Worker EC2 Instance type"
  default     = ["t3a.medium", "r5.2xlarge", "r4.2xlarge"]
}

variable "spot_instance_pools" {
  type        = string
  description = "Number EC2 Instance type"
  default     = "3"
}

variable "spot_price" {
  type    = string
  default = "0.20"
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::249565476171:user/tgaleev"
      username = "tgaleev"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
  ]
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)
  default     = []
}