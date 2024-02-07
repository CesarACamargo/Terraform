resource "aws_s3_bucket" "s3binf" {
  bucket = "lab-s3-infra"

  tags = {
    Name  = "LabS3 Infra"
  }
}