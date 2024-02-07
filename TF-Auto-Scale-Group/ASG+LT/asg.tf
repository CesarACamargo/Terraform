// Launch Template
resource "aws_launch_template" "ltlab" {
  name          = var.launch_template
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    arn = var.arn
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  network_interfaces {
    security_groups = var.security_groups
    subnet_id       = var.subnet_id
  }
}

// Auto Scale Group //
resource "aws_autoscaling_group" "asglab" {
  name               = var.aws_autoscaling_group
  availability_zones = var.availability_zones
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ltlab.id
    version = aws_launch_template.ltlab.latest_version
  }

  tag {
    key                 = "Name"
    value               = var.launch_template
    propagate_at_launch = true
  }
}

