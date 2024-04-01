
resource "aws_security_group" "access_bastion_sg" {
  name        = "acesso-porteiro-ssm-tf"
  description = "TF - Acesso do porteiro"
  vpc_id      = var.vpc_id

  egress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    security_groups = [aws_security_group.endpoint_sg.id]
    description     = "Liberado para VPC Endpoint"
  }

  egress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.private_subnet_ssm_nat_cidr]
    description = "Liberado para Subnet Zona B com NAT"
  }
}

resource "aws_security_group" "endpoint_sg" {
  name        = "ssm-vpc-endpoint-tf"
  description = "TF - Acesso do vpc endpoint para o ssm"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet_ssm_cidr]
    description = "Liberado para range da subnet do porteiro"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "access_ec2_sg" {
  name        = "acesso-ec2-ssm-endpoint_tf"
  description = "TF - Acesso para EC2 via porteiro"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.access_bastion_sg.id]
    description     = "Liberado para o porteiro"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}



