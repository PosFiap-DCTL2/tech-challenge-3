### Cluster EKS ###

resource "aws_eks_cluster" "clusterpos" {
  name     = "clusterpos"
  role_arn = var.lab_role_arn
  version  = "1.31"

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids         = var.subnets
    security_group_ids = [var.grupodeseguranca]
  }
}


### Node Group EKS ###

resource "aws_eks_node_group" "nodegrouppos" {
  cluster_name    = aws_eks_cluster.clusterpos.name
  node_group_name = "nodegrouppos"
  node_role_arn   = var.lab_role_arn
  subnet_ids      = var.subnets

  instance_types = var.instance_types

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.clusterpos
  ]

}