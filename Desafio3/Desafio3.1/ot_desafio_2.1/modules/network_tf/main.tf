locals {
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}

resource "aws_vpc" "vpc_tf" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "vpc_tf"
  }
}

# Criação das Subnets Pública e Privada
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_tf.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(local.availability_zones, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subrede-public-tf"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc_tf.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(local.availability_zones, count.index)
  map_public_ip_on_launch = "false"

  tags = {
    Name = "subrede-private-tf"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "igw_tf" {
  vpc_id = aws_vpc.vpc_tf.id

  tags = {
    Name = "internet-gateway-tf"
  }
}

# Elastic IP para NAT
resource "aws_eip" "nat-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_tf]

  tags = {
    Service = "Managed by OpenTofu"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  tags = {
    Name = "nat-tf"
  }
}

# Criação da Tabela de Roteamento
resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc_tf.id

  tags = {
    Name = "Tabela de rotas privadas-tf"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc_tf.id

  tags = {
    Name = "Tabelas de rotas publicas-tf"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_tf.id
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

# DB Subnet Group
resource "aws_db_subnet_group" "subgroup_tf" {
  name       = "tf-subnet-group"
  subnet_ids = flatten([aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id])
   
  tags = {
    Name = "TF - DB subnet group"
  }
}
