provider "aws" {
  region = var.region
  assume_role {
    role_arn = local.credentials.role
  }
}
