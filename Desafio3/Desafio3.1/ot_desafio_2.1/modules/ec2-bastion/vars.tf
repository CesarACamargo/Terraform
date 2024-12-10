variable "ami-tf" {
  type        = string
  default     = "ami-1234567890"
  description = "TF-EC2 BASTION"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "key_name" {
  type    = string
  default = "xxxxxxxxxx"
}

variable "public_subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

# IAM Roles
variable "iam_instance_profile" {
  type    = string
  default = "role-acesso-ssm"
}

