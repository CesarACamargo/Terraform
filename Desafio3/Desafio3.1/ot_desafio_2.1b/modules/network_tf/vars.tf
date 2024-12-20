variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  description = "CIDR block for Private Subnet"
}
