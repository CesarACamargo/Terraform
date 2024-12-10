variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "master_username" {
  type    = string
  default = "xxxxxxxxxxxx"
}

variable "pwd_username" {
  type      = string
  default   = "xxxxxxxxxxxx"
  sensitive = true
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "parameter_group_name" {
  default = "default.postgres15"
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "backup_retention_period" {
  type    = number
  default = 0
}

### Referencias para modulos
variable "db_subnet_group_name" {
  type        = string
  description = "DB Grupo de seguranca"
}

variable "vpc_security_group_ids" {
  type = string
}
