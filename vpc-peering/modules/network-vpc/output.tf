output "vpc_sp_id" {
  value = aws_vpc.vpc_sp.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_id_2" {
  value = aws_subnet.public-subnet-2.id
}

