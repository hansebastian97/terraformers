provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
  assume_role {
    role_arn = local.credentials.role
  }
}

provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
  assume_role {
    role_arn = local.credentials.role
  }
}