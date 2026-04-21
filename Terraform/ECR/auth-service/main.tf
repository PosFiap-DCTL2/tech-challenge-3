resource "aws_ecr_repository" "auth-service-ECR" {
  name                 = "auth-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}