# print information
output "address_endpoint" {
  description = "RDS instance hostname"
  value       = aws_db_instance.myinstancedb.endpoint
}

output "db_user_admin" {
  description = "RDS instance root username"
  value       = aws_db_instance.myinstancedb.username
}

output "instance_port" {
  description = "RDS instance port"
  value       = aws_db_instance.myinstancedb.port
}
