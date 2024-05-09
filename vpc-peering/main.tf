## VPC
module "vpc_sp" {
  source = "./modules/network-vpc"

  vpc_peering_connection_id = module.peering_vpc.vpc_peering_connection_id
}

## Security Group
module "security_groups" {
  source = "./modules/security_resources"

  vpc_id = module.vpc_sp.vpc_sp_id
}

## Instance EC2
module "ec2-lnx" {
  source = "./modules/ec2-lnx"

  public_sg_id     = module.security_groups.ssh_connect_lnx
  public_subnet_id = module.vpc_sp.public_subnet_id_1
}

## VPC Peering
module "peering_vpc" {
  source = "./modules/peering-vpc"

  vpc_id_sp = module.vpc_sp.vpc_sp_id
}
