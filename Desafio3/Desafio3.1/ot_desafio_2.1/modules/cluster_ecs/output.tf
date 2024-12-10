
output "aws_launch_template" {
  value = aws_launch_template.lt-xyz.id
}

output "arn_ecs_cluster" {
  value = aws_ecs_cluster.ecs_xyz.arn
}

output "name_ecs_cluster" {
  value = aws_ecs_cluster.ecs_xyz.name
}


