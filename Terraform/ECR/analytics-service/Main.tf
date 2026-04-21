resource "aws_ecr_repository" "analytics-service-ECR" {
  name                 = "analytics-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}