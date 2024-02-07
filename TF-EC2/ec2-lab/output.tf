output "aws_instance_id" {
  value = aws_instance.ami-lab.id
}

output "public_dns" {
  value = aws_instance.ami-lab.public_dns
}

output "public_ip" {
  value = aws_instance.ami-lab.public_ip
}