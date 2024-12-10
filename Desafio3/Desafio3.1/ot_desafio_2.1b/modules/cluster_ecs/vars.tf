variable "project_name" {
  type    = string
  default = "cluster-bia-alb"
}

variable "name_alb" {
  type    = string
  default = "asg-bia-alb"
}

variable "name_service" {
  type    = string
  default = "service-bia-alb"
}

variable "family" {
  type    = string
  default = "task-def-bia-alb"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

/*
variable "key_name" {
  type      = string
  default   = "key-lab-treino"
  sensitive = true
}
*/

variable "availability_zones" {
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b"]
  description = "azs disponiveis"
}


### Referencias para modulo-root 'main.tf'
variable "security_group_id" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "image_url" {
  type = string
  //  default = "123456789101.dkr.ecr.us-east-1.amazonaws.com/bia:latest"
}

variable "endpointdb" {
  type = string
  //  default = "bia-db.cuvdlnah8sds.us-east-1.rds.amazonaws.com"
}

variable "target_group_arn" {
  type        = string
  description = "ARN do target group "
}

/*
*/
