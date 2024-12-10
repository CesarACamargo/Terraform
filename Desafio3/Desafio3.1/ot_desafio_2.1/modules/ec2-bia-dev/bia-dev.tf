resource "aws_instance" "bia-dev-tf" {
  ami                         = var.ami-tf
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = file("script-userdata.sh")

  tags = {
    "Name" = "bia-dev-tf"
  }
}


