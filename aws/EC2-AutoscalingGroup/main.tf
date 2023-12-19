module "vpc-singapore" {
  source = "./modules/VPC"
  providers = {
    aws = "aws.ap-southeast-1"
  }

  vpc_name   = "CDN-VPC1"
  cidr_block = "10.3.0.0/16"
  subnet = {
    subnet-public1 = {
      name              = "subnet-public1"
      subnet_cidr       = "10.3.16.0/20"
      availability_zone = "ap-southeast-1a"
      type              = "public"
    },
    subnet-private1 = {
      name              = "subnet-private1"
      subnet_cidr       = "10.3.32.0/20"
      availability_zone = "ap-southeast-1b"
      type              = "private"
    },
    subnet-public2 = {
      name              = "subnet-public2"
      subnet_cidr       = "10.3.48.0/20"
      availability_zone = "ap-southeast-1c"
      type              = "public"
    }
  }

}

module "vpc-sydney" {
  source = "./modules/VPC"

  providers = {
    aws = "aws.ap-southeast-2"
  }

  vpc_name   = "CDN-VPC2"
  cidr_block = "10.1.0.0/16"
  subnet = {
    subnet-public1 = {
      name              = "subnet-public1"
      subnet_cidr       = "10.1.16.0/20"
      availability_zone = "ap-southeast-2a"
      type              = "public"
    }

    subnet-public2 = {
      name              = "subnet-public2"
      subnet_cidr       = "10.1.32.0/20"
      availability_zone = "ap-southeast-2b"
      type              = "public"
    }

    subnet-private2 = {
      name              = "subnet-private2"
      subnet_cidr       = "10.1.48.0/20"
      availability_zone = "ap-southeast-2c"
      type              = "private"
    }
  }
}

module "EC2-autoscaling-VPC1" {

  # Module Configuration
  source = "./modules/EC2-autoscaling"
  providers = {
    aws = "aws.ap-southeast-1"
  }
  depends_on = [module.vpc-singapore]

  subnet         = module.vpc-singapore.subnet
  vpc_name       = module.vpc-singapore.vpc_name
  vpc_id         = module.vpc-singapore.vpc_id
  security_group = module.vpc-singapore.security_group_id

  # Launch Template Configuration
  launch_template_availability_zone = "ap-southeast-1a"

  # Autoscaling Group Configuration
  subnet_group = ["subnet-public1", "subnet-public2"]
}

module "EC2-autoscaling-VPC2" {


  # Module Configuration
  source = "./modules/EC2-autoscaling"
  providers = {
    aws = "aws.ap-southeast-2"
  }
  depends_on     = [module.vpc-sydney]
  subnet         = module.vpc-sydney.subnet
  vpc_name       = module.vpc-sydney.vpc_name
  vpc_id         = module.vpc-sydney.vpc_id
  security_group = module.vpc-sydney.security_group_id

  # Launch Template Configuration
  launch_template_availability_zone = "ap-southeast-2a"

  # Autoscaling Group Configuration
  subnet_group = ["subnet-public1", "subnet-public2"]
}
