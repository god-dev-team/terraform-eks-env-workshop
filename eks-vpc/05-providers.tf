provider "aws" {
  region  = var.aws_region
  version = "~>2.66"
}

provider "random" {
  version = "~> 2.1"
}