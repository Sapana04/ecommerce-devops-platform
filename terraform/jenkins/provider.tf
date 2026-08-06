terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }

  backend "s3" {
    bucket         = "riva-ecommerce-terraform-state"
    key            = "jenkins/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    bucket = "riva-ecommerce-terraform-state"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}