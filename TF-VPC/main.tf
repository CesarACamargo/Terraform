terraform {
  required_version = ">= 0.52.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  #  backend "s3" {
  #    bucket = "s3-remote-state"
  #    key    = "aws-vpc/terraform.tfstate"
  #    region = var.region
  #  }
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
