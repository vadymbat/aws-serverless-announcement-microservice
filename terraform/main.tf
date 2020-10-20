terraform {
  required_version = ">=0.12.29"
}

provider "aws" {
  region = var.aws_region
}


module "dynamodb_crud_policy" {
  source = ""
  
}