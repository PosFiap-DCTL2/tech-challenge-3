### Cluster EKS ###

resource "aws_eks_cluster" "clusterpos" {
  name = "clusterpos"

  access_config {
    authentication_mode = "API"
  }
  
  bootstrap_self_managed_addons = true
  role_arn = "arn:aws:iam::123945314948:role/LabRole"
  version  = "1.30"

  compute_config {
    enabled = true
    node_pools = ["general-purpose"]
    node_role_arn = arn:aws:iam::123945314948:role/LabRole

  }

  vpc_config {
    subnet_ids = [
        var.subnet_ids[0],
        var.subnet_ids[1],  
        var.subnet_ids[2],
        var.subnet_ids[3],
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKS_CNI_Policy,
  ]
}

### Node Group EKS ###

resource "aws_eks_node_group" "nodegrouppos" {
  cluster_name    = aws_eks_cluster.clusterpos.name
  node_group_name = "nodegrouppos"
  node_role_arn   = "arn:aws:iam::123945314948:role/LabRole"
  subnet_ids      = var.subnet_ids

  capacity_type   = "ON_DEMAND"
  instance_types  = var.instance_types
  
  force_update_version = true

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

depends_on = [
  aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
  aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
  aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
]
}