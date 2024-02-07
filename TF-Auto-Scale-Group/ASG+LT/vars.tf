variable "launch_template" {
  default     = "lt-instance-ec2"
  description = "Launch Template EC2"
}

variable "image_id" {
  type    = string
  default = "ami-0a3c3a20c09d6f377"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "key-lab-treino"
}

variable "arn" {
  default = "arn:aws:iam::206322024537:instance-profile/ecsInstanceRole"
}

variable "security_groups" {
  default = ["sg-0323d07dcd813bce7"]
}

variable "subnet_id" {
  default = "subnet-065e4da5e788feb8d"
}

variable "aws_autoscaling_group" {
  default = "asg-lab"
}

variable "availability_zones" {
  default = ["us-east-1a"]
}

