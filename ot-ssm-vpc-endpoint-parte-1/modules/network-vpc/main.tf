resource "aws_vpc" "vpc_ssm" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-ssm-tf"
  }
}

# Subnet private
resource "aws_subnet" "private-subnet-ssm" {
  vpc_id            = aws_vpc.vpc_ssm.id
  cidr_block        = var.private_subnet_ssm_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "tf-private-subnet-bastion-ssm"
  }
}

# Route tables for the subnets
resource "aws_route_table" "rt_porteiro" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-route-table-porteiro"
  }
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "tf-private-rta-assoc" {
  route_table_id = aws_route_table.rt_porteiro.id
  subnet_id      = aws_subnet.private-subnet-ssm.id
}

/*
# Endpoints
resource "aws_vpc_endpoint" "endpoint_ssm" {
  vpc_id            = aws_vpc.vpc_ssm.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [ aws_subnet.private-subnet-ssm.id ]

  tags = {
    "Name" = "vpc-endpoint-ssm"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.vpc_ssm.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [ aws_subnet.private-subnet-ssm.id ]

  tags = {
    "Name" = "vpc-endpoint-ssm-ec2messages"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.vpc_ssm.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [ aws_subnet.private-subnet-ssm.id ]

  tags = {
    "Name" = "vpc-endpoint-ssm-ssmmessages"
  }
}


/*
# Internet Gateway for the private subnet
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-igw-ssm"
  }
}

# Route tables for the subnets (Default)
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-rt-default"
  }
}

# Route the private subnet traffic through the Internet Gateway
resource "aws_route" "tf-private-subnet-route" {
  route_table_id         = aws_route_table.private-route-table.id
  gateway_id             = aws_internet_gateway.tf-igw.id
  destination_cidr_block = var.vpc_cidr
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "tf-private-rt-assoc" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-ssm.id
}
*/


