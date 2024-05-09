variable "aws_region" {
  default = "sa-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.77.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_1_cidr" {
  default     = "172.77.1.0/24"
  description = "CIDR block for Public Subnet 1"
}

variable "public_subnets_2_cidr" {
  default     = "172.77.2.0/24"
  description = "CIDR block for Public Subnet"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1b"]
  description = "Availability zones"
}

variable "vpc_peering_connection_id" {
  type = string
}

