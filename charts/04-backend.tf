terraform {
  backend "s3" {
    bucket         = "tfstate-demo-infra"
    key            = "terraform/states/eks-demo-charts.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tfstate_demo"
  }
  required_version = ">= 0.12.0"
}