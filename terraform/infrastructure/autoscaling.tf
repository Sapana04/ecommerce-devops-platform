resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.app_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_name}-app"
      Environment = var.environment
    }
  }
}
resource "aws_autoscaling_group" "app_asg" {
  name = "${var.project_name}-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  target_group_arns = [
    aws_lb_target_group.app_tg.arn
  ]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-app"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}