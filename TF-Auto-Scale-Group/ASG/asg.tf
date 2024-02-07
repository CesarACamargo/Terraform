resource "aws_autoscaling_group" "asglab" {
    name = "asg-lab"
    desired_capacity = 1
    max_size = 1
    min_size = 1
}

