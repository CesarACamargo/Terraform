# --- Create launch template ---
resource "aws_launch_template" "lt_bia" {
  name                   = "lt-${var.project_name}"
  image_id               = "ami-05fc769a34ddda96c"
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  //  key_name               = var.key_name

  iam_instance_profile {
    arn = "arn:aws:iam::123456789101:instance-profile/ecsInstanceRole"
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${var.project_name} >> /etc/ecs/ecs.config;
    EOF
  )
}


# --- Create auto scaling group ---
resource "aws_autoscaling_group" "asg_bia" {
  name_prefix = "TF-ECS-Cluster-${var.name_alb}"
  //  name                = var.name_alb
  vpc_zone_identifier = var.subnet_ids

  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.lt_bia.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.project_name
    propagate_at_launch = true
  }
}


# --- Create cluster ---
resource "aws_ecs_cluster" "ecs_bia" {
  name = var.project_name

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
}


# --- Create capacity provider ---
resource "aws_ecs_capacity_provider" "ecs_capacity_prov" {
  name = "cluster-asg-bia-alb"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg_bia.arn
    managed_draining               = "ENABLED"
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 3
      maximum_scaling_step_size = 100
      minimum_scaling_step_size = 1
    }
  }
}


# --- Create Cluster capacity provider ---
resource "aws_ecs_cluster_capacity_providers" "cluster_prov" {
  cluster_name       = aws_ecs_cluster.ecs_bia.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_prov.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_prov.name
    base              = 0
    weight            = 1
  }
}


# --- ECS Task Role ---
data "aws_iam_policy_document" "ecs_task_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


# --- IAM Roles ---
resource "aws_iam_role" "ecs_task_role" {
  name_prefix        = "tf-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

resource "aws_iam_role" "ecs_exec_role" {
  name_prefix        = "tf-ecs-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_doc.json
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  role       = aws_iam_role.ecs_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# --- Create Task definition ---
resource "aws_ecs_task_definition" "task_def_bia_alb" {
  family                   = var.family
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_exec_role.arn
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  //  execution_role_arn       = "arn:aws:iam::123456789101:role/ecsTaskExecutionRole"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = <<TASK_DEFINITION
  [
    {
      "name":  "bia",
      "image": "${var.image_url}",
      "cpu": 1024,
      "memory": 512,
      "memoryReservation": 307,
      "portMappings": [
        {
          "name": "porta-aleatoria",
          "hostPort": 0,
          "containerPort": 8080,
          "protocol": "tcp",
          "appProtocol": "http"          
        }
      ],
      "essential": true,
      "environment": [
        { 
          "name": "DB_HOST",
          "value": "${var.endpointdb}"
        },
        { 
          "name": "DB_USER",
          "value": "rasec"
        },  
        {
          "name": "DB_PWD",
          "value": "treino-2024"
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
           "awslogs-group": "/ecs/task_def_bia_alb",
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
    "owner"      = "ccamargo"
  }
}


# --- Create the ECS Service ---
resource "aws_ecs_service" "ecs_service" {
  name                              = var.name_service
  cluster                           = aws_ecs_cluster.ecs_bia.id
  task_definition                   = aws_ecs_task_definition.task_def_bia_alb.arn
  launch_type                       = "EC2"
  health_check_grace_period_seconds = 0
  desired_count                     = 2
  scheduling_strategy               = "REPLICA"

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100

  deployment_circuit_breaker {
    enable   = false #true
    rollback = false #true
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

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "bia"
    container_port   = 8080
  }

  depends_on = [aws_autoscaling_group.asg_bia]
}

