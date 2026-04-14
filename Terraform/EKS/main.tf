resource "aws_eks_cluster" "clusterpos" {
  name = "clusterpos"

  access_config {
    authentication_mode = "API"
  }
  
  bootstrap_self_managed_addons = true
  role_arn = arn:aws:iam::123945314948:role/LabRole
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
      aws_subnet.az3.id,
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}