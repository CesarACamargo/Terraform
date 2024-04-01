variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.35.0.0/16"
  description = "CIDR block of the vpc-ssm"
}

variable "private_subnet_ssm_cidr" {
  default     = "172.35.0.0/20"
  description = "CIDR block for Private Subnet SSM"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a"]
  description = "Availability zones"
}

variable "security_group_id" {
  type = list(any)
}

