output "ssh_bastion_sg" {
  value = aws_security_group.ssh_bastion_sg.id
}

output "app_xyz_dev" {
  value = aws_security_group.app_xyz_dev.id
}

output "xyz_web_sg" {
  value = aws_security_group.xyz_web_sg.id
}

output "xyz_db_sg" {
  value = aws_security_group.xyz_db_sg.id
}

output "xyz_alb_sg" {
  value = aws_security_group.xyz_alb_sg.id
}