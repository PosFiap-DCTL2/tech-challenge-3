output "private_subnet_ids" {
  value = [
    aws_subnet.subnetprivada1.id,
    aws_subnet.subnetprivada2.id
  ]
}

output "vpc_id" {
  value = aws_vpc.vpcpos.id
}

output "redis_config" {
  description = "Configurações necessárias para o Redis"
  value = {
    subnet_group_id   = aws_elasticache_subnet_group.redis_subnet_group.id
    security_group_id = aws_security_group.redis.id
  }
}

output "rds_config" {
  description = "Configurações necessárias para o RDS"
  value = {
    subnet_group_id   = aws_db_subnet_group.rds_subnet_group.id
    security_group_id = aws_security_group.rds.id
  }
}

output "eks_config" {
  description = "Configurações necessárias para o EKS"
  value = {
    subnet_ids = [aws_subnet.subnetprivada1.id, aws_subnet.subnetprivada2.id, aws_subnet.subnetpublica1.id, aws_subnet.subnetpublica2.id]
  }
}

