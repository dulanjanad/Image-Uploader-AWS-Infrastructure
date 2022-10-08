resource "aws_ecr_repository" "image-uploader-ecr" {
  name                 = "image-uploader"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}