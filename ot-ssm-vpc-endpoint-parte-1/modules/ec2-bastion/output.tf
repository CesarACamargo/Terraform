output "aws_instance_id" {
  value = aws_instance.ami-bastion.id
}

output "public_dns" {
  value = aws_instance.ami-bastion.private_dns
}

output "public_ip" {
  value = aws_instance.ami-bastion.private_ip
}

