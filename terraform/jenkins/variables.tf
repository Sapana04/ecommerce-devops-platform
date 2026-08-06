variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "instance_type" {
  description = "Jenkins EC2 Instance Type"
  type        = string
}

variable "key_name" {
  description = "Jenkins EC2 Key Pair Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where Jenkins will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where Jenkins will be deployed"
  type        = string
}

variable "owner" {
  description = "Owner of resources"
  type        = string
}

variable "managed_by" {
  description = "Tool used to manage infrastructure"
  type        = string
}