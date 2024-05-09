
# aws_instance.ec2_lab:
resource "aws_instance" "ami-lnx" {
  ami                         = var.ami-lnx
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]

  tags = {
    "Name" = "ec2-vpc-peering-sp"
  }
}