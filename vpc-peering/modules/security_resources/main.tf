
resource "aws_security_group" "ssh_connect_lnx" {
  name        = "ssh_connect_lnx"
  description = "TF - SG para conectividade EC2 Linux"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.34.0.0/16"]
    description = "Liberado SSH da rede 172.34.0.0/16"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.34.0.0/16"]
    description = "Liberado Ping da rede 172.34.0.0/16"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

