variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable "cidr" {
  type        = string
  description = "CIDR"
}

variable "vpc_name" {
  type        = string
  description = "TEST"
}

variable "current_public_ip" {
  type        = string
  description = "Current Public IP of my Broadband provider"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "nodes_count" {
  type        = number
  description = "Number of worker nodes to be provisioned"
}

variable "redhat_ami" {
  default     = "ami-035c5dc086849b5de"
  type        = string
  description = "Red Hat AMI"
}

variable "environment" {
  type        = string
  description = "Red Hat AMI"
}

variable "efs_name" {
  type        = string
  description = "EFS Name"
}