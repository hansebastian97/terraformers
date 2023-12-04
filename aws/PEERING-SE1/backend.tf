terraform {
  backend "s3" {
    region = "ap-southeast-1"
    bucket = "bucket1-terraform-state"
    key    = "aws/01. VPC_PEERING_LAB/PEERING-SE1"
  }
}
