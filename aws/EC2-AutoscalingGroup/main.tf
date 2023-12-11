module "vpc" {
  source = "./modules/VPC"

  vpc_name   = "VPC-03"
  cidr_block = "10.3.0.0/16"
  subnet = {
    subnet-public1 = {
      name              = "subnet-public1"
      subnet_cidr       = "10.3.16.0/20"
      availability_zone = "ap-southeast-1a"
      type              = "public"
    }

    subnet-public2 = {
      name              = "subnet-public2"
      subnet_cidr       = "10.3.32.0/20"
      availability_zone = "ap-southeast-1b"
      type              = "private"
    }
  }
  #   tags = {
  #     Terraform   = "true"
  #     Environment = "dev"
  #   }
}