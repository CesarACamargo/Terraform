# print information
output "address_endpoint" {
  description = "RDS instance hostname"
  value       = aws_db_instance.desafiodb-v2.endpoint
}

output "db_user_admin" {
  description = "RDS instance root username"
  value       = aws_db_instance.desafiodb-v2.username
}

output "arn" {
  description = "The ARN of the DB instance"
  value       = aws_db_instance.desafiodb-v2.arn
}