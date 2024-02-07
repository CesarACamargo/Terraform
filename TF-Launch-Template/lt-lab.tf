resource "aws_launch_template" "lab" {
  name     = "lt-instance-ec2"
  image_id = data.aws_ami.ubuntu.id
  #  image_id      = "ami-0a3c3a20c09d6f377"
  instance_type = "t3.micro"
  key_name      = "key-lab-treino"

  iam_instance_profile {
    arn = "arn:aws:iam::206322024537:instance-profile/ecsInstanceRole"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  network_interfaces {
    security_groups = ["sg-0323d07dcd813bce7"]
    subnet_id       = "subnet-065e4da5e788feb8d"
  }
}

output "aws_launch_template" {
  value = aws_launch_template.lab.id
}

output "aws_ami" {
  value = data.aws_ami.ubuntu.image_id
}