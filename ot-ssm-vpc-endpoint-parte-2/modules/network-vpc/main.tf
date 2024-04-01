resource "aws_vpc" "vpc_ssm" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-ssm-tf"
  }
}

# Subnets private
resource "aws_subnet" "public-subnet-ssm" {
  vpc_id            = aws_vpc.vpc_ssm.id
  cidr_block        = var.public_subnet_ssm_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "tf-public-subnet-ssm"
  }
}

resource "aws_subnet" "private-subnet-ssm-nat" {
  vpc_id            = aws_vpc.vpc_ssm.id
  cidr_block        = var.private_subnet_ssm_nat_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "tf-private-subnet-ssm-nat"
  }
}

resource "aws_subnet" "private-subnet-ssm" {
  vpc_id            = aws_vpc.vpc_ssm.id
  cidr_block        = var.private_subnet_ssm_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "tf-private-subnet-bastion-ssm"
  }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "igw-ssm" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-igw-ssm"
  }
}

####################### Elastic IP para NAT
#
resource "aws_eip" "nat-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw-ssm]

  tags = {
    Service = "Managed by OpenTofu"
  }
}

####################### NAT Gateway
#
resource "aws_nat_gateway" "nat-ssm" {
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-eip.id
  subnet_id         = element(aws_subnet.public-subnet-ssm.*.id, 0)

  tags = {
    Name = "igw-nat-tf"
  }
}

# Route tables for the subnet public
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-route-table-public"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-route-table-private"
  }
}

# Route
resource "aws_route" "tf-rt-public-gw-ssm" {
  route_table_id         = aws_route_table.rt_public.id
  gateway_id             = aws_internet_gateway.igw-ssm.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_internet_gateway" {
  route_table_id         = aws_route_table.rt_private.id
  gateway_id             = aws_nat_gateway.nat-ssm.id
  destination_cidr_block = "0.0.0.0/0"

}

# Route tables for the subnet porteiro
resource "aws_route_table" "rt_porteiro" {
  vpc_id = aws_vpc.vpc_ssm.id

  tags = {
    Name = "tf-route-table-porteiro"
  }
}

# Associate the newly created route tables to the subnets public and private
resource "aws_route_table_association" "tf-private-rta-assoc" {
  route_table_id = aws_route_table.rt_porteiro.id
  subnet_id      = aws_subnet.private-subnet-ssm.id
}

resource "aws_route_table_association" "tf-private-rt-ssm-assoc" {
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = aws_subnet.private-subnet-ssm-nat.id
}


# Endpoints
resource "aws_vpc_endpoint" "endpoint_ssm" {
  vpc_id              = aws_vpc.vpc_ssm.id
  service_name        = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [aws_subnet.private-subnet-ssm.id]

  tags = {
    "Name" = "vpc-endpoint-ssm"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.vpc_ssm.id
  service_name        = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [aws_subnet.private-subnet-ssm.id]

  tags = {
    "Name" = "vpc-endpoint-ssm-ec2messages"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.vpc_ssm.id
  service_name        = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = var.security_group_id

  subnet_ids = [aws_subnet.private-subnet-ssm.id]

  tags = {
    "Name" = "vpc-endpoint-ssm-ssmmessages"
  }
}




