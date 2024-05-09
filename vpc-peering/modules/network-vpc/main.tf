resource "aws_vpc" "vpc_sp" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-peering-sp"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.vpc_sp.id
  cidr_block        = var.public_subnets_1_cidr
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.vpc_sp.id
  cidr_block        = var.public_subnets_2_cidr
  availability_zone = var.availability_zones[1]
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.vpc_sp.id

  tags = {
    Name = "tf-igw"
  }
}

# Route tables for the subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_sp.id

  tags = {
    Name = "tf-rt-public"
  }
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "tf-public-gw-route" {
  route_table_id            = aws_route_table.public-route-table.id
  gateway_id                = aws_internet_gateway.tf-igw.id
  destination_cidr_block    = "0.0.0.0/0"
  vpc_peering_connection_id = var.vpc_peering_connection_id
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "tf-public-rt-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

resource "aws_db_subnet_group" "subgroup_tf" {
  name       = "tf-subnet-group"
  subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  tags = {
    Name = "TF - DB subnet group"
  }
}

