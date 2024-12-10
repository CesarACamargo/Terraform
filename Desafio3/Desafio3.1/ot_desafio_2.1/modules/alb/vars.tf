variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "instance_id" {
  type = string
}