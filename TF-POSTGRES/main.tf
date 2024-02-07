terraform {
  required_version = ">= 0.52.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region


  default_tags {
    tags = {
      owner      = "ccamargo"
      managed-by = "opentofu"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "http" "my_ip" {
  url = "http://checkip.amazonaws.com"
}

resource "aws_security_group" "postgres-sg" {
  vpc_id      = data.aws_vpc.default.id
  name        = "postgres-sg"
  description = "Allow all inbound for Postgres"

  # Only postres in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
    #  cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a RDS Database Instance
resource "aws_db_instance" "desafiodb-v2" {

  identifier              = "desafiodb-v2"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t3.micro"
  storage_type            = "gp2"
  db_name                 = "desafiodb"
  username                = "rasec"
  password                = "treino-2024"
  vpc_security_group_ids  = [aws_security_group.postgres-sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  parameter_group_name    = var.parameter_group_name
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  # Storage options
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
}
