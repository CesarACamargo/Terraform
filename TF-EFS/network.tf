resource "aws_vpc" "default" {
  cidr_block           = "172.31.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "efs" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "172.31.32.0/20"
  availability_zone = "us-east-1a"
}