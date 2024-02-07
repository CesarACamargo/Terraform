output "aws_s3_bucket" {
  description = "ARN do bucket"
  value       = aws_s3_bucket.s3binf.arn
}

output "bucket_id" {
  description = "ID do Bucket criada na AWS"
  value       = aws_s3_bucket.s3binf.id
}
