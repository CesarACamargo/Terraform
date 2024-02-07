// VPC
resource "aws_vpc" "lab" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-opentofu"
  }
}

// SUBNET
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.lab.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-opentofu"
  }
}

// GATEWAY
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "internet-gateway-opentofu"
  }
}

// ROUTE
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "route-table-opentofu"
  }
}

// ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

// Security group resources
resource "aws_security_group" "security_group" {
  name   = "securety_group_opentofu"
  description = "Liberar porta 22"
  vpc_id = aws_vpc.lab.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}