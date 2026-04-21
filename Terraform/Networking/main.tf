## VPC ###

resource "aws_vpc" "vpcpos" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

}

### Subnets ###
resource "aws_subnet" "subnetpublica1" {
  vpc_id                  = aws_vpc.vpcpos.id
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[0]
}

resource "aws_subnet" "subnetpublica2" {
  vpc_id                  = aws_vpc.vpcpos.id
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[1]
}

resource "aws_subnet" "subnetprivada1" {
  vpc_id                  = aws_vpc.vpcpos.id
  cidr_block              = "172.16.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[0]
}

resource "aws_subnet" "subnetprivada2" {
  vpc_id                  = aws_vpc.vpcpos.id
  cidr_block              = "172.16.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[1]
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.subnetprivada1.id, aws_subnet.subnetprivada2.id]
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnetprivada1.id, aws_subnet.subnetprivada2.id]
}

### Tabela de Roteamento Pública ###

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.vpcpos.id

  route {
    cidr_block = "0.0.0.0/0"
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

### Security Group ###

resource "aws_security_group" "eks" {
  name        = "eks-security-group"
  description = "Security Group do EKS"
  vpc_id      = aws_vpc.vpcpos.id

  egress {
    description = "EKS pode sair para qualquer destino"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_1" {
  name        = "rds-security-group"
  description = "Security Group do RDS"
  vpc_id      = aws.vpc.vpcpos.id

  ingress {
    description     = "Postgres somente do EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.eks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redis" {
  name        = "redis-security-group"
  description = "Redis acessível apenas pelo EKS"
  vpc_id      = aws.vpc.vpcpos.id

  ingress {
    description     = "Redis somente do EKS"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.eks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}