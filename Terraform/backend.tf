terraform {
  backend "s3" {
    bucket = "bucketguardastateterraform"
    key    = "terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
