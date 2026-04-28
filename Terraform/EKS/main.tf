### Cluster EKS ###

resource "aws_eks_cluster" "clusterpos" {
  name     = "clusterpos"
  role_arn = var.lab_role_arn
  version  = "1.35"

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids         = var.subnets
    security_group_ids = [var.grupodeseguranca]
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.clusterpos.name
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

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "4.5.2"
  namespace        = "argocd"
  create_namespace = true

  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]
}