terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      owner      = "cacamargo"
      managed-by = "terraform"
    }
  }
}

# Security group resources
#
resource "aws_security_group" "rds_sg_terraform" {
  name        = "rds_sg_terraform"
  description = "EC2 security group (terraform-managed)"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    security_group = "ec2-terraform"
  }
}

# Create a RDS Database Instance
resource "aws_db_instance" "postgrelsql" {
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg_terraform.id]
  multi_az               = true

  # resource identifier
  identifier = "${var.project_name}-rds-${var.environment}"

  # Storage options
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
}
