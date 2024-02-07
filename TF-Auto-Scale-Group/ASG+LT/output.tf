output "aws_launch_template" {
  value = aws_launch_template.ltlab.id
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.asglab.name
}