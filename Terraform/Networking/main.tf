## VPC ###

resource "aws_vpc" "vpcpos" {
  cidr_block = "172.16.0.0/24"
}

### Subnets ###
resource "aws_subnet" "subnetpublica" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.1.0/24"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnetprivada" {
    vpc_id = aws_vpc.vpcpos.id
    cidr_block = "172.16.2.0/24"
    map_public_ip_on_launch = false
}

### Tabela de Roteamento ###

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.vpcpos.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "tabeladerotapublica" {
  subnet_id      = aws_subnet.subnetpublica.id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table" "privada" {
  vpc_id = aws_vpc.vpcpos.id
}

resource "aws_route_table_association" "tabeladerotaprivada" {
  subnet_id      = aws_subnet.subnetprivada.id
  route_table_id = aws_route_table.privada.id
}

### Gateway de internet ###

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpcpos.id
}