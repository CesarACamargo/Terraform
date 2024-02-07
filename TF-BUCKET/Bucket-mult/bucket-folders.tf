variable "s3_bucket_list" {
  type    = list(any)
  default = ["01-dev", "03-prod", "02-hom"]
}

resource "aws_s3_bucket" "mult_bucket" {
  for_each = toset(var.s3_bucket_list)
  bucket   = each.key
}