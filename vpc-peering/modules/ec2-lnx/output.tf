output "aws_instance_id" {
  value = aws_instance.ami-lnx.id
}

output "public_dns" {
  value = aws_instance.ami-lnx.public_dns
}



