resource "aws_s3_bucket" "ansible_ssm" {
  bucket = "${var.project_name}-ansible-ssm-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.project_name}-ansible-ssm"
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = var.managed_by
  }
}

data "aws_caller_identity" "current" {}
