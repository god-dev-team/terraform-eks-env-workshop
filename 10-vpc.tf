module "network" {
  source             = "./modules/network"
  environment        = var.environment
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_name       = var.cluster_name

  ### vpc: 10.${var.network}.0.0/16
  network = var.network_id

  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}