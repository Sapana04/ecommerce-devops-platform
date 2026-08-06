# ============================================================
# Latest Amazon Linux 2023 AMI
# ============================================================

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ============================================================
# Application EC2 Instance
# ============================================================

resource "aws_instance" "app" {
  iam_instance_profile = aws_iam_instance_profile.app_profile.name
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = var.instance_type

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-app"
    Role = "Application"
  }
}
