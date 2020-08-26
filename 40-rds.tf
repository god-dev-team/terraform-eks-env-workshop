# module "rds" {
#   source        = "./modules/rds"
#   environment   = var.environment
#   cluster_name  = var.cluster_name
#   vpc_id        = module.network.vpc_id

#   ### DB settings:
#   db_backup_retention = "30"
#   instance_class      = "db.t2.micro"
#   allocated_storage   = "5"
# }