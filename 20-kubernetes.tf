module "kubernetes" {
  source              = "./modules/kubernetes"

  environment         = var.environment
  cluster_name        = var.cluster_name
  max_cluster_size    = var.spot_max_cluster_size
  desired_capacity    = var.spot_desired_capacity
  min_cluster_size    = var.spot_min_cluster_size
  cluster_version     = var.cluster_version
  instance_type       = var.spot_instance_type
  aws_region          = data.aws_region.current.name
  vpc_id              = module.network.vpc_id
  private_subnets     = module.network.private_subnets
}