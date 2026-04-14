## VPC ###

resource "aws_vpc" "vpcpos" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

}

### Subnets ###
resource "aws_subnet" "subnetpublica1" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "subnetpublica2" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = var.availability_zones[1]
}

resource "aws_subnet" "subnetprivada1" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.3.0/24"
    map_public_ip_on_launch = false
    availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "subnetprivada2" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = var.availability_zones[1]
}


### Tabela de Roteamento Pública ###

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.vpcpos.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "tabeladerotapublica1" {
  subnet_id      = aws_subnet.subnetpublica1.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "tabeladerotapublica2" {
  subnet_id      = aws_subnet.subnetpublica2.id
  route_table_id = aws_route_table.publica.id
}

### Tabela de Roteamento Privada ###

resource "aws_route_table" "privada" {
  vpc_id = aws_vpc.vpcpos.id
}

resource "aws_route_table_association" "tabeladerotaprivada1" {
  subnet_id      = aws_subnet.subnetprivada1.id
  route_table_id = aws_route_table.privada.id
}

resource "aws_route_table_association" "tabeladerotaprivada2" {
  subnet_id      = aws_subnet.subnetprivada2.id
  route_table_id = aws_route_table.privada.id
}

### Gateway de internet ###

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpcpos.id
}