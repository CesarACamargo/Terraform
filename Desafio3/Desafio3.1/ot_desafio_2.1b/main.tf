### VPC
module "network_tf" {
  source = "./modules/network_tf"
  vpc_id = module.network_tf.vpc_id
}

### Security Groups
module "security_resources" {
  source = "./modules/security_resources"
  vpc_id = module.network_tf.vpc_id
}

### RDS Database
module "rds_database" {
  source                 = "./modules/rds_database"
  db_subnet_group_name   = module.network_tf.aws_db_subnet_group
  vpc_security_group_ids = module.security_resources.bia_db_sg
}

### Repositorio ECR
module "ecr_repo" {
  source = "./modules/ecr_repo"
}

### Cluster ECS
module "cluster_ecs" {
  source            = "./modules/cluster_ecs"
  target_group_arn  = module.alb.target_group_arn
  security_group_id = module.security_resources.bia_ec2_sg #bia_web_sg
  subnet_ids        = module.network_tf.private_subnet_id[*]
  image_url         = module.ecr_repo.url_repo
  endpointdb        = module.rds_database.endpointdb
}

### Auto Scaling Load Balancer
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network_tf.vpc_id
  instance_id       = module.ec2-bia-dev.target_id
  security_group_id = module.security_resources.bia_alb_sg
  subnet_ids        = module.network_tf.public_subnet_id[*]
}

/*
### Instancias EC2
module "ec2-bastion" {
  source            = "./modules/ec2-bastion"
  vpc_id            = module.network_tf.vpc_id
  security_group_id = module.security_resources.ssh_bastion_sg
  public_subnet_id  = tostring(module.network_tf.public_subnet_id[0])
}
*/

module "ec2-bia-dev" {
  source            = "./modules/ec2-bia-dev"
  vpc_id            = module.network_tf.vpc_id
  security_group_id = module.security_resources.app_bia_dev
  private_subnet_id = tostring(module.network_tf.private_subnet_id[0])
}

/*
*/