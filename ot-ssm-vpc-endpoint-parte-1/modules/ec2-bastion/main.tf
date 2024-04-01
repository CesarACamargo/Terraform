
resource "aws_instance" "ami-bastion" {
  ami                         = var.ami-bastion
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  availability_zone           = var.availability_zone
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.private_sg_id]

  tags = {
    "Name" = "ec2-ssm-subnet-private-tf"
  }
}