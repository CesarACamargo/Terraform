variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc-ssm"
  type        = string
  default     = "172.35.0.0/16"
  
}

variable "public_subnet_ssm_cidr" {
  description = "CIDR block for Private Subnet SSM"
  default     = "172.35.32.0/20"
}

variable "private_subnet_ssm_cidr" {
  description = "CIDR block for Private Subnet SSM"
  default     = "172.35.0.0/20"
}

variable "private_subnet_ssm_nat_cidr" {
  description = "CIDR block for Private Subnet SSM NAT"
  default     = "172.35.16.0/20"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "security_group_id" {
  type = list(any)
}

