# test 1
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
  assume_role {
    role_arn = "arn:aws:iam::084825817586:role/EC2_FullAccess"
  }
}

resource "aws_instance" "test_server" {
  ami           = "ami-02453f5468b897e31"
  instance_type = "t2.micro"

  tags = {
    Name = "test_server"
  }
}
