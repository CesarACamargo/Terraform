
# Create a RDS Database Instance
resource "aws_db_instance" "bia-db" {
  identifier     = "bia-db"
  engine         = "postgres"
  engine_version = "15.5"
  instance_class = "db.t3.micro"
  storage_type   = "gp2"
  db_name        = "biadb"
  username       = var.master_username
  password       = var.pwd_username

  allocated_storage       = var.allocated_storage
  skip_final_snapshot     = true
  publicly_accessible     = false
  monitoring_interval     = 0
  parameter_group_name    = var.parameter_group_name
  backup_retention_period = var.backup_retention_period

  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [var.security_group_id]
  availability_zone = var.availability_zone
}
