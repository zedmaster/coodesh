resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "coodesh"
  }
}

# Sub-redes públicas
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"
}


# Gateway da Internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "coodesh-igw" }
}

# Tabela de Roteamento Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associação das sub-redes públicas à tabela de roteamento pública
resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


# Gateway NAT
resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public1.id
}



# VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Lista de IDs das sub-redes públicas
output "public_subnet_ids" {
  value = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

