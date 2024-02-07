output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "securety_group_id" {
  value = aws_security_group.security_group.id
}