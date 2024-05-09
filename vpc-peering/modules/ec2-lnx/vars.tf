variable "ami-lnx" {
  type        = string
  default     = "ami-"
  description = "Instancia EC2 - VPC Peering - TF"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {}

// Network //
variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "public_sg_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}




