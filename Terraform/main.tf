terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "analytics_service" {
  source = "./DynamoDB"
}

module "ECR_analytics_service" {
  source = "./ECR/analytics-service"
}

module "ECR_auth_service" {
  source = "./ECR/auth-service"
}

module "ECR_evaluation_service" {
  source = "./ECR/evaluation-service"
}

module "ECR_flag_service" {
  source = "./ECR/flag-service"
}

module "ECR_targeting_service" {
  source = "./ECR/targeting-service"
}

module "EKS_cluster" {
  source     = "./EKS"
  subnets = module.Networking.eks_config.eks_subnet_ids
  grupodeseguranca = module.Networking.eks_config.eks_security_group_id
}

module "Networking" {
  source = "./Networking"
}

module "RDS_auth_db" {
  source  = "./RDS/RDS1"
  network = module.Networking.rds_config
}

module "RDS_flags_db" {
  source  = "./RDS/RDS2"
  network = module.Networking.rds_config
}

module "RDS_targeting_db" {
  source  = "./RDS/RDS3"
  network = module.Networking.rds_config
}

module "Redis_DB" {
  source  = "./Redis"
  network = module.Networking.redis_config
}

module "SQS" {
  source = "./SQS"
}
