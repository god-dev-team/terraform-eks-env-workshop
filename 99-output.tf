output "eks_name" {
  value = module.kubernetes.cluster_name
}

output "region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "update_kubeconfig" {
  value = "aws eks update-kubeconfig --name ${module.kubernetes.cluster_name} --alias ${module.kubernetes.cluster_name}"
}
