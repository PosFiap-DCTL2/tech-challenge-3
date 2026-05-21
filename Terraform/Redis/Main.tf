resource "aws_elasticache_replication_group" "evaluation-service" {
  replication_group_id   = "evaluation-service"
  description            = "Redis para avaliação"
  engine                 = "redis"
  engine_version         = "7.1"
  node_type              = "cache.t3.micro"
  num_node_groups        = 1
  replicas_per_node_group = 0
  parameter_group_name   = "default.redis7"
  port                   = 6379

  subnet_group_name      = var.network.subnet_group_id
  security_group_ids     = [var.network.security_group_id]
}
