// security.tf
resource "aws_security_group" "sg-nfs" {
  name        = "ingress-efs-test-sg"
  vpc_id      = aws_vpc.default.id
  description = "Allow NFS inbound traffic"

  ingress {
    description = "NFS access allow to efs"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver_EFS_SG"
  }
}