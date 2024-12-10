# print information
output "db_address" {
  value = aws_db_instance.bia-db.address
}

output "endpointdb" {
  description = "RDS instance hostname"
  value       = aws_db_instance.bia-db.endpoint
}

output "db_user_admin" {
  description = "RDS instance root username"
  value       = aws_db_instance.bia-db.username
}

output "arn" {
  description = "The ARN of the DB instance"
  value       = aws_db_instance.bia-db.arn
}