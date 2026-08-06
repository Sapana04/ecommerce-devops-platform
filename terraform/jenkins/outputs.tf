output "jenkins_public_ip" {
  description = "Jenkins Server Public IP"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_public_dns" {
  description = "Jenkins Server Public DNS"
  value       = aws_instance.jenkins.public_dns
}

output "jenkins_instance_id" {
  description = "Jenkins EC2 Instance ID"
  value       = aws_instance.jenkins.id
}