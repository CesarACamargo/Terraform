variable "region" {
  default = "us-east-1"
}

variable "azs" {
  default = {
    "us-east-1" = "us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f"
  }
}