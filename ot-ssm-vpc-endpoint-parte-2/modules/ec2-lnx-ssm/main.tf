
resource "aws_instance" "ami-lnx-ssm" {
  ami                         = var.ami-lnx
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]

  tags = {
    "Name" = "Maq3 instance ec2"
  }
}