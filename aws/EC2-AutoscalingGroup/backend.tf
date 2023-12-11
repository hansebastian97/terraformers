terraform {
  backend "s3" {
    bucket = "bucket1-terraform-state"
    region = "ap-southeast-1"
    key    = "aws/02. VPC_TEST"
  }
}
