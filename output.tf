output "vpc_id" {
  value = module.vpc.vpc_id
}

output "worker_nodes_public_ip" {
  value = aws_instance.worker_nodes.public_ip
}

output "worker_nodes_private_ip" {
  value = aws_instance.worker_nodes.private_ip
}

output "efs_dns" {
  value = aws_efs_file_system.efs.dns_name
}

output "ecr_url" {
  value = aws_ecr_repository.image-uploader-ecr.repository_url
}