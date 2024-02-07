variable "ami-lab" {
  type        = string
  default     = "ami-0a3c3a20c09d6f377"
  description = "Instancia EC2 Lab"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "key_name" {
  type    = string
  default = "key-lab-treino"
}


/* Network */

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "cidr_block_vpc" {
  default = "172.31.0.0/16"
}

variable "subnet_id" {
  type    = string
  default = "subnet-065e4da5e788feb8d"
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = ["sg-0323d07dcd813bce7"]
}
