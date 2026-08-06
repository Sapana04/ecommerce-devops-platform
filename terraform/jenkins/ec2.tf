data "aws_ssm_parameter" "jenkins_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ssm_parameter.jenkins_ami.value
  instance_type = var.instance_type

  subnet_id = data.terraform_remote_state.infrastructure.outputs.public_subnet_1_id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  key_name = aws_key_pair.jenkins_key.key_name

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  associate_public_ip_address = true

  tags = {
    Name        = "${var.project_name}-jenkins"
    Role        = "jenkins"
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = var.managed_by
  }
}