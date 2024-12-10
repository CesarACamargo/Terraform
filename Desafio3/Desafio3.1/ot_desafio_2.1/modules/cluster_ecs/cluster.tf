
# Create launch template
resource "aws_launch_template" "lt-xyz" {
  name                   = "lt-${var.project_name}"
  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile {
    arn = "arn:aws:iam::1234567890:instance-profile/ecsInstanceRole"
  }

  user_data = base64encode(<<-EOF
    echo ECS_CLUSTER=cluster-xyz >> /etc/ecs/ecs.config;
    EOF
  )
}

# Create auto scaling group
resource "aws_autoscaling_group" "asg-xyz" {
  name_prefix         = "${var.name_prefix}-"
  vpc_zone_identifier = var.subnet_ids

  desired_capacity          = 1
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.lt-xyz.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.project_name
    propagate_at_launch = true
  }
}

# Create capacity privider
resource "aws_ecs_capacity_provider" "ecs-capacity-prov" {
  name = "Infra-ECS-cluster-${aws_autoscaling_group.asg-xyz.name}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg-xyz.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 5
      maximum_scaling_step_size = 100
      minimum_scaling_step_size = 1
    }
  }
}

# Create cluster
resource "aws_ecs_cluster" "ecs_bia" {
  name = var.project_name
}

resource "aws_ecs_cluster_capacity_providers" "cluster-prov" {
  capacity_providers = [aws_ecs_capacity_provider.ecs-capacity-prov.name]
  cluster_name       = aws_ecs_cluster.ecs_bia.name

  default_capacity_provider_strategy {
    base              = 0
    capacity_provider = aws_ecs_capacity_provider.ecs-capacity-prov.name
    weight            = 1
  }
}

# Create Task definition
resource "aws_ecs_task_definition" "task-def-xyz" {
  family                   = var.family
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  execution_role_arn       = "arn:aws:iam::1234567890:role/ecsTaskExecutionRole"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = <<TASK_DEFINITION
  [
    {
      "name":  "xyz",
      "image": "${var.image_url}",
      "cpu": 1024,
      "memory": 512,
      "memoryReservation": 307,
      "portMappings": [
        {
          "name": "xyz-80",
          "hostPort": 80,
          "containerPort": 8080,
          "protocol": "tcp",
          "appProtocol": "http"          
        }
      ],
      "essential": true,
      "environment": [
        { 
          "name": "DB_HOST",
          "value": ${var.address_endpoint_db}
        },
        { 
          "name": "DB_USER",
          "value": "fulano"
        },  
        {
          "name": "DB_PWD",
          "value": "xxxxxxxxxx"
        },
        {  
          "name": "DB_PORT", 
          "value": "5432"
        }
      ],
      "logConfiguration": {
         "logDriver": "awslogs",
         "options": {
           "awslogs-create-group": "true",
           "awslogs-group": "/ecs/task-def-xyz",
           "awslogs-region": "us-east-1",
           "awslogs-stream-prefix": "ecs"
          } 
       }
    }
  ]
  TASK_DEFINITION

  skip_destroy = false
  tags_all = {
    "managed-by" = "OpenTofu"
    "owner"      = "fulano"
  }
}

resource "aws_ecs_service" "default" {
  cluster                           = var.project_name
  desired_count                     = 1
  name                              = var.name_service
  task_definition                   = "arn:aws:ecs:us-east-1:1234567890:task-definition/task-def-xyz:1"
  launch_type                       = "EC2"
  health_check_grace_period_seconds = 0
  scheduling_strategy               = "REPLICA"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
}

