resource "aws_ecr_repository" "flag-service-ECR" {
  name                 = "flag-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}