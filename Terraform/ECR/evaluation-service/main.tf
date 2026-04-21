resource "aws_ecr_repository" "evaluation-service-ECR" {
  name                 = "evaluation-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}