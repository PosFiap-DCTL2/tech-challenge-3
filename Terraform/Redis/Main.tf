resource "aws_elasticache_cluster" "evaluation-service" {
  cluster_id           = "evaluation-service"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379

  subnet_group_name  = var.network.subnet_group_id
  security_group_ids = [var.network.security_group_id]
}