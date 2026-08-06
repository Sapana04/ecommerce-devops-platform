# ============================================================
# App EC2 IAM Role
# ============================================================

resource "aws_iam_role" "app_role" {
  name = "${var.project_name}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-app-role"
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = var.managed_by
  }
}


# ============================================================
# Amazon SSM
# ============================================================

resource "aws_iam_role_policy_attachment" "app_ssm_core" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# ============================================================
# CloudWatch
# ============================================================

resource "aws_iam_role_policy_attachment" "app_cloudwatch_agent" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


# ============================================================
# App EC2 Instance Profile
# ============================================================

resource "aws_iam_instance_profile" "app_profile" {
  name = "${var.project_name}-app-profile"
  role = aws_iam_role.app_role.name
}