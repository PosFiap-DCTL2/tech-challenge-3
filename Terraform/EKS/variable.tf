variable "instance_types" {
  description = "Variavel para troca de tipo de instanca"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "lab_role_arn" {
  description = "ARN of the AWS Academy LabRole"
  type        = string
  default     = "arn:aws:iam::123945314948:role/LabRole"
}

variable "subnet_eks" {
  description = "Subnets do EKS"
  type        = list(string)
}
