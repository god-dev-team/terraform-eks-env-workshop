module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name = "${var.environment}-${var.cluster_name}"

  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  # assign_generated_ipv6_cidr_block = true

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_enable_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name                                        = "${var.environment}-${var.cluster_name}-public"
    KubernetesCluster                           = var.cluster_name
    Environment                                 = var.environment
    "kubernetes.io/role/elb"                    = ""
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Name                                        = "${var.environment}-${var.cluster_name}-private"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
    Name        = "${var.environment}-${var.cluster_name}"
    Environment = var.environment
    Terraform   = "true"
  }
}