
output "vpc_ssm_id" {
  value = aws_vpc.vpc_ssm.id
}

output "private_subnet_ssm_id" {
  value = aws_subnet.private-subnet-ssm.id
}

output "private_subnet_ssm_cidr" {
  value = aws_subnet.private-subnet-ssm.cidr_block
}
