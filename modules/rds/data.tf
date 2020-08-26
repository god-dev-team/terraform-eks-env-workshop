data "aws_subnet_ids" "all" {
  vpc_id = var.vpc_id
}

data "aws_security_group" "default" {
  vpc_id = var.vpc_id
  name   = "default"
}