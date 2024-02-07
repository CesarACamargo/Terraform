terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"


  default_tags {
    tags = {
      owner      = "ccamargo"
      managed-by = "opentofu"
    }
  }
}


# Create a RDS Database Instance
resource "aws_db_instance" "myinstancedb" {

  identifier = "wordpressdb"

  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"

  db_name  = "wordpressdb"
  username = "admin"
  password = "treino-2024"
  port     = "3306"

  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["sg-04b7baead8a587931"]
  skip_final_snapshot    = true
  publicly_accessible    = true

  # Storage options
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
}
