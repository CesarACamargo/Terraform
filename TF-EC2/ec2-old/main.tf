terraform {
  required_version = ">= 0.52.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner      = "ccamargo"
      managed-by = "OpenTofu"
    }
  }
}

locals {
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}