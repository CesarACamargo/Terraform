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
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "ccamargo"
      managed-by = "OpenTofu"
    }
  }
}

