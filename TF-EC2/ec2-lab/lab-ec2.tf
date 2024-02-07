# aws_instance.ec2_lab:
resource "aws_instance" "ami-lab" {
  ami                         = var.ami-lab
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids

  user_data = <<-EOF
    #!/bin/bash
    sudo dnf update -y

    #Here the swap file is 2 GB (128 MB x 16):
    sudo dd if=/dev/zero of=/swapfile bs=128M count=16

    #Updating file permission
    sudo chmod 600 /swapfile

    #Set up a Linux swap folder
    sudo mkswap /swapfile

    #Add swap file to swap space to make it available for use
    sudo swapon /swapfile

    #Verify taks is completed
    sudo swapon -s
  EOF

  /*cpu_options {
    core_count       = 1
    threads_per_core = 2
  }*/

  tags = {
    "Name" = "ami-ec2-lab"
  }
}