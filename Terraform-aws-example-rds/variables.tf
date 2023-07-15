variable "environment" {
  description = "setup the environment"
}

variable "project_name" {
  description = "Nome do projeto"
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  type = string
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = false
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "key_pair_name" {
  type = string
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
