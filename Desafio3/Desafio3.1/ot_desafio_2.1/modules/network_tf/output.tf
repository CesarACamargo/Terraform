
output "vpc_id" {
  value = aws_vpc.vpc_tf.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.subgroup_tf.name
}