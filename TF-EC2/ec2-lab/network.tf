resource "aws_vpc" "Default" {
  cidr_block = var.cidr_block_vpc

  tags = {
    Name = "Default"
  }
}