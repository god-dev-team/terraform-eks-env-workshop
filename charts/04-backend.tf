terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket         = "tfstate-demo-infra"
    key            = "terraform/states/charts.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tfstate_god_charts"
  }
}