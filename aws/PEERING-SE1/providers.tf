provider "aws" {
  alias  = "aws_PEERING-SE1"
  region = var.region
  assume_role {
    role_arn = local.credentials.role
  }
}
