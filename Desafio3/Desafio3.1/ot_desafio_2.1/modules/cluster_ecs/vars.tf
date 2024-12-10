variable "project_name" {
  type    = string
  default = "cluster-tf"
}

variable "ami" {
  type = string
  default = "ami-1234567891011"
}

variable "name_prefix" {
  type    = string
  default = "asg-tf"
}

variable "name_service" {
  type    = string
  default = "service-tf"
}

variable "family" {
  type    = string
  default = "task-def-tf"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type      = string
  default   = "xxxxxxxx"
  sensitive = true
}

variable "availability_zones" {
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b"]
  description = "azs disponiveis"
}



### Referencias para modulos
variable "security_group_id" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "image_url" {
  type = string
}

variable "address_endpoint_db" {
  type = string
}