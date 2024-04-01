## VPC
module "network-vpc" {
  source = "./modules/network-vpc"
  version = "1.1.0"

  security_group_id = [module.security_resources.endpoint_sg]
}

## Security Groups
module "security_resources" {
  source = "./modules/security_resources"

  vpc_id                      = module.network-vpc.vpc_ssm_id
  private_subnet_ssm_cidr     = module.network-vpc.private_subnet_ssm_cidr
  private_subnet_ssm_nat_cidr = module.network-vpc.private-subnet-ssm-nat
}

## Instances EC2
module "ec2-bastion" {
  source = "./modules/ec2-bastion"

  private_sg_id     = module.security_resources.access_bastion_sg
  private_subnet_id = module.network-vpc.private_subnet_ssm_id
}

module "ec2-lnx-ssm" {
  source = "./modules/ec2-lnx-ssm"

  public_sg_id      = module.security_resources.access_ec2_sg
  private_subnet_id = module.network-vpc.private_subnet_ssm_nat_id
}



/*
# Acessar instancia via ssm
# aws ssm start-session --target $INSTANCE_ID --document-name AWS-StartInteractiveCommand --parameters command="bash -l"
*/