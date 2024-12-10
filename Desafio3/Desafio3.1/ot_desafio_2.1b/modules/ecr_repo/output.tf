output "ecr_repo" {
  value = aws_ecr_repository.ecr_repo.arn
}

output "url_repo" {
  value = aws_ecr_repository.ecr_repo.repository_url
}

output "name_repo" {
  value = aws_ecr_repository.ecr_repo.name
}