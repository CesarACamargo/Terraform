terraform {
  required_version = ">= 0.52.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "sa-east-1"
  profile = "default"

  default_tags {
    tags = {
      owner      = "ccamargo"
      managed-by = "OpenTofu"
    }
  }
}

