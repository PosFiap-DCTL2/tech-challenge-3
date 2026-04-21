output "private_subnet_ids" {
  value = [
    aws_subnet.subnetprivada1.id,
    aws_subnet.subnetprivada2.id
  ]
}

output "vpc_id" {
  value = aws_vpc.vpcpos.id
}