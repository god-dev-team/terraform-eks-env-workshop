module "network" {
  source             = "./modules/network"
  environment        = var.environment
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  cluster_name       = var.cluster_name

  ### vpc: 10.${var.network}.0.0/16
  network            = var.network_id
}