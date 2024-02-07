output "aws_s3_bucket" {
  description = "ARN do bucket"
  value       = [for x in aws_s3_bucket.mult_bucket : x.arn]
}

output "bucket_id" {
  description = "ID do Bucket criada na AWS"
  value       = [for y in aws_s3_bucket.mult_bucket : y.id]
}

