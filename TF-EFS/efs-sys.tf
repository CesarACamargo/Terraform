resource "aws_efs_file_system" "efs-volume" {
  creation_token   = "lab-efs-storage"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  depends_on = [aws_security_group.sg-nfs]

  tags = {
    Name = "lab-efs-storage"
  }
}

/* Mount target */
resource "aws_efs_mount_target" "efs-mt-example" {
  file_system_id  = aws_efs_file_system.efs-volume.id
  subnet_id       = aws_subnet.efs.id
  security_groups = [aws_security_group.sg-nfs.id]
}