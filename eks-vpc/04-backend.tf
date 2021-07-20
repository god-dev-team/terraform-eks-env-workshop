terraform {
  required_version = ">= 0.14"
  backend "s3" {
    bucket         = "tfstate-demo-infra"
    key            = "terraform/states/eks.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tfstate_god"
  }
}
