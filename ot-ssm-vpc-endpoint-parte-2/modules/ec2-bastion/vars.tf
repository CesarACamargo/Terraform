variable "ami-bastion" {
  type        = string
  default     = "ami-0d7a109bf30624c99"
  description = "Instancia EC2 Porteiro"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "private_sg_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

# IAM Roles
variable "iam_instance_profile" {
  type    = string
  default = "role-acesso2-ssm"
}
