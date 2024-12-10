resource "aws_instance" "bastion-tf" {
  ami                         = var.ami-tf
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = var.iam_instance_profile
 
  tags = {
    "Name" = "bastion-tf"
  }
}


