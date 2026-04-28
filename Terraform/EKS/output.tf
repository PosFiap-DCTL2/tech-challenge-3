output "cluster_endpoint" {
  value = aws_eks_cluster.clusterpos.endpoint
}

output "cluster_authority_data" {
  value = aws_eks_cluster.clusterpos.certificate_authority[0].data
}

output "cluster_token" {
  value     = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}