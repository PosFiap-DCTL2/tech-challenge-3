variable "availability_zones" {
  description = "Availability Zones usadas pelas subnets do EKS (us-east-1)"
  type        = list(string)
  default     = [
    "us-east-1a",
    "us-east-1b"
  ]
}
