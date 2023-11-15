terraform {
  backend "s3" {
    bucket         = "recipe-app-api-devops-tfstate-project"
    key            = "recipe-app.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "recipe-app-api-devops-tf-state-lock-dra"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 4.67.0"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}

