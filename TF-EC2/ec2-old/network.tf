resource "aws_vpc" "lab_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "Lab-VPC"
  }
}

# Criação das Subnets Pública e Privada
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.lab_vpc.id
  count             = length(var.public_subnets_cidr)
  cidr_block        = element(var.public_subnets_cidr, count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = "subrede-public-1"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.lab_vpc.id
  count             = length(var.private_subnets_cidr)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = "subrede-private-1"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "lab-igw" {
  vpc_id = aws_vpc.lab_vpc.id
  tags = {
    Name = "internet-gateway-lab"
  }
}

# Elastic IP para NAT
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.lab-igw]
}
# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  tags = {
    Name = "nat"
  }
}

# Criação da Tabela de Roteamento
resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "Tabela de rotas privadas"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "Tabelas de rotas publicas"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab-igw.id
}

# Route for NAT Gateway
resource "aws_route" "private_internet_gateway" {
  route_table_id         = aws_route_table.rtb_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat.id
}


# Associação da Subnet Pública com a Tabela de Roteamento
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.rtb_private.id
}

# Security group resources
#
resource "aws_security_group" "allow_http" {
  name   = "securety_group_for_http"
  vpc_id = aws_vpc.lab_vpc.id

  description = "Permitir SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
