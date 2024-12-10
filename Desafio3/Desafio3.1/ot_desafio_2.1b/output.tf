output "vpc_tf" {
  value = module.network_tf.vpc_id
}


output "db_subnet_group_name" {
  value = module.network_tf.aws_db_subnet_group
}


output "ecr_repo" {
  value = module.ecr_repo.url_repo
}


output "address_endpoint_db" {
  value = module.rds_database.endpointdb
}

