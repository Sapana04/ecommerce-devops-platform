output "vpc_id" {
  value = aws_vpc.main.id
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.app_asg.name
}
output "ecr_repository_url" {
  description = "Amazon ECR Repository URL"
  value       = aws_ecr_repository.app_repository.repository_url
}

output "ecr_repository_name" {
  description = "Amazon ECR Repository Name"
  value       = aws_ecr_repository.app_repository.name
}