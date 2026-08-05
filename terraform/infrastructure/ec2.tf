# Get latest Amazon Linux 2023 AMI

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.jenkins_instance_type

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  associate_public_ip_address = true

  tags = {

    Name = "${var.project_name}-jenkins"

    Role = "Jenkins"

  }

}