terraform {
  backend "s3" {
    bucket         = "sapana-ecommerce-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}