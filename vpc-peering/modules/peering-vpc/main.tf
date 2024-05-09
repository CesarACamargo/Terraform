provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

# VPC Peering connection from VPC_SP to VPC_Virginia
resource "aws_vpc_peering_connection" "peer_sp_to_vg" {
  provider = aws.us-east-1 # Você precisa definir explicitamente o provedor para a região us-east-1

  vpc_id      = var.vpc_id_sp
  peer_vpc_id = var.vpc_da_virginia_id

  auto_accept = true # Se desejar que a conexão seja aceita automaticamente

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

# Aceitar automaticamente a conexão no lado da VPC_Virginia
resource "aws_vpc_peering_connection_accepter" "peering_accepter_vg" {
  provider = aws.us-east-1

  vpc_peering_connection_id = aws_vpc_peering_connection.peer_sp_to_vg.id

  auto_accept = true # Aceita automaticamente a conexão

  tags = {
    Side = "Accepter"
  }
}
