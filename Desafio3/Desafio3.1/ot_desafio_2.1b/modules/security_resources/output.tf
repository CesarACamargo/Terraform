output "ssh_bastion_sg" {
  value = aws_security_group.ssh_bastion_sg.id
}

output "app_bia_dev" {
  value = aws_security_group.app_bia_dev.id
}

output "bia_web_sg" {
  value = aws_security_group.bia_web_sg.id
}

output "bia_db_sg" {
  value = aws_security_group.bia_db_sg.id
}

output "bia_alb_sg" {
  value = aws_security_group.bia_alb_sg.id
}

output "bia_ec2_sg" {
  value = aws_security_group.bia_ec2_sg.id
}