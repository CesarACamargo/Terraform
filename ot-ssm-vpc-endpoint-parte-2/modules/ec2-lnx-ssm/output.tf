output "aws_instance_id" {
  value = aws_instance.ami-lnx-ssm.id
}

output "public_dns" {
  value = aws_instance.ami-lnx-ssm.public_dns
}

output "private_ip" {
  value = aws_instance.ami-lnx-ssm.private_ip
}


