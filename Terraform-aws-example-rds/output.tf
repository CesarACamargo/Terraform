# print information
output "address_endpoint" {
  description = "RDS instance hostname"
  value       = aws_db_instance.postgrelsql.address
}

output "db_user_admin" {
  description = "RDS instance root username"
  value       = aws_db_instance.postgrelsql.username
}

output "instance_port" {
  description = "RDS instance port"
  value       = aws_db_instance.postgrelsql.port
}

output "securety_group_id" {
  description = "RDS Security Group"
  value       = aws_security_group.rds_sg_terraform.id
}

