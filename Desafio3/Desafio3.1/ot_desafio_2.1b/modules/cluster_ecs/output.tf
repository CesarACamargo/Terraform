
output "aws_launch_template" {
  value = aws_launch_template.lt_bia.id
}

output "arn_ecs_cluster" {
  value = aws_ecs_cluster.ecs_bia.arn
}

output "name_ecs_cluster" {
  value = aws_ecs_cluster.ecs_bia.name
}


