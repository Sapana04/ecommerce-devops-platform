resource "aws_iam_role" "jenkins_role" {

  name = "${var.project_name}-jenkins-role"

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

    Name        = "${var.project_name}-jenkins-role"
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = var.managed_by

  }

}

########################################################
# Amazon SSM
########################################################

resource "aws_iam_role_policy_attachment" "ssm_core" {

  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

########################################################
# CloudWatch
########################################################

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {

  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

########################################################
# Custom ECR IAM Policy
########################################################

resource "aws_iam_policy" "jenkins_ecr_policy" {

  name        = "${var.project_name}-jenkins-ecr-policy"
  description = "Custom ECR policy for Jenkins"

  policy = file("${path.module}/../iam-policies/ecr-policy.json")
}

########################################################
# Attach Custom ECR Policy to Jenkins Role
########################################################

resource "aws_iam_role_policy_attachment" "jenkins_ecr_policy_attachment" {

  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.jenkins_ecr_policy.arn
}

########################################################
# Instance Profile
########################################################

resource "aws_iam_instance_profile" "jenkins_profile" {

  name = "${var.project_name}-jenkins-profile"

  role = aws_iam_role.jenkins_role.name

}