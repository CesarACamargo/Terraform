
data "external" "public_ip" {
  program = ["bash", "${path.module}/get_public_ip.sh"]
}

locals {
  public_ip = data.external.public_ip.result["ip"]
}

resource "aws_security_group" "ssh_bastion_sg" {
  name        = "ssh_bastion_sg"
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.public_ip}/32"] #My-IP
  }
}


resource "aws_security_group" "app_bia_dev" {
  name        = "app-xyz-dev"
  description = "TF-Acesso da BIA para ec2-xyz-dev"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3001
    to_port         = 3001
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.ssh_bastion_sg.id] # Bastion
    description     = "Liberado para application xyz"
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "bia_web_sg" {
  vpc_id      = var.vpc_id
  name        = "xyz-web"
  description = "TF-Allow all inbound for HTTP"

  # Only postres in
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "TF-Acesso da Web"
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "bia_db_sg" {
  vpc_id      = var.vpc_id
  name        = "xyz-db"
  description = "TF-Allow all inbound to xyz-db"

  # Only postres in
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.bia_web_sg.id] #Bia Web
    description     = "TF-Acesso da xyz-web"
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_bia_dev.id] #Bia Dev
    description     = "TF-Acesso da xyz-dev"
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.bia_ec2_sg.id] #Bia EC2
    description     = "TF-Acesso da xyz-ec2"
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Para utilização do ALB 

resource "aws_security_group" "bia_alb_sg" {
  name        = "xyz-alb"
  vpc_id      = var.vpc_id
  description = "Security group for ALB"

  # Only postres in
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "TF-Liberado para a Web"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "TF-Liberado para a HTTPS"
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bia_ec2_sg" {
  vpc_id      = var.vpc_id
  name        = "xyz-ec2"
  description = "TF-Allow all inbound for EC2-BIA"

  # Only postres in
  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "tcp"
    security_groups = [aws_security_group.bia_alb_sg.id]
    description     = "TF-Liberado para xyz-ec2"
  }

  # Allow all unbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 