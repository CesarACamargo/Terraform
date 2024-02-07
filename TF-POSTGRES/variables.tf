variable "region" {
  default = "us-east-1"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "backup_window" {
  default = "03:00-03:30"
}

variable "parameter_group_name" {
  default = "default.postgres15"
}


