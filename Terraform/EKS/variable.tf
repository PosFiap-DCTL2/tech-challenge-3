variable "subnet_ids" {
  description = "IDs das subnets usadas pelo EKS"
  type        = list(string)
  default     = [
    "aws_subnet.subnetpublica1.id",
    "aws_subnet.subnetpublica2.id",
    "aws_subnet.subnetprivada1.id",
    "aws_subnet.subnetprivada2.id"
  ]
}

variable "instance_types" {
  description = "Variavel para troca de tipo de instanca"
  type = string
  default = "t3.medium"
}