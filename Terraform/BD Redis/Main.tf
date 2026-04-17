resource "aws_elasticache_cluster" "evaluation-service" {
  cluster_id           = "evaluation-service"
  engine               = "redis"
  node_type            = "cache.m4.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
}