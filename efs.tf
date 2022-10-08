resource "aws_efs_file_system" "efs" {
  creation_token = var.efs_name

  tags = {
    Name = "${var.efs_name}-${var.environment}"
    Environment = var.environment
  }
}