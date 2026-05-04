data "aws_eks_cluster" "this" {
  name       = aws_eks_cluster.clusterpos.name
  depends_on = [aws_eks_cluster.clusterpos]  # ← garante que o cluster existe antes
}

data "aws_eks_cluster_auth" "this" {
  name       = aws_eks_cluster.clusterpos.name
  depends_on = [aws_eks_cluster.clusterpos]  # ← idem
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.this.certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.this.certificate_authority[0].data
    )
    token = data.aws_eks_cluster_auth.this.token
  }
}