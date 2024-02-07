/* https://groups.google.com/g/terraform-tool/c/_Ipj7tY86FI?pli=1 */

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
  count           = length(split(", ", lookup(var.azs, var.region)))
  file_system_id  = aws_efs_file_system.efs-volume.id
  subnet_id       = element(aws_subnet.efs.*.id, 0)
  security_groups = [aws_security_group.sg-nfs.id]
}