output "access_bastion_sg" {
  value = aws_security_group.access_bastion_sg.id
}

output "endpoint_sg" {
  value = aws_security_group.endpoint_sg.id
}



