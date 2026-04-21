resource "aws_ecr_repository" "targeting-service-ECR" {
  name                 = "targeting-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}