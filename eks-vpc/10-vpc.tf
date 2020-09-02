module "network" {
  source             = "./modules/network"
  environment        = var.environment
  availability_zones = var.availability_zones
  cluster_name       = var.cluster_name

  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr

  vpc_enable_nat_gateway = var.vpc_enable_nat_gateway

}