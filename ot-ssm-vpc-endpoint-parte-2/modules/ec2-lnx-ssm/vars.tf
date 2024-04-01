variable "ami-lnx" {
  type        = string
  default     = "ami-0d7a109bf30624c99"
  description = "EC2 Machine 3 - TF"
}

variable "instance_type" {
  type    = string
  default = "t4g.nano"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1b"
}

// Network //
variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "public_sg_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

/*
# IAM Roles
variable "iam_instance_profile" {
  type    = string
  default = "role-acesso2-ssm"
}
*/



