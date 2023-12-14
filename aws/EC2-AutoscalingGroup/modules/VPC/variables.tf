# Module Variable
variable "vpc_name" {
    type = string
}

variable "cidr_block" {
    type = string
}



variable "subnet" {
  type = list(object({
    name                 = string
    subnet_cidr          = string
    availability_zone    = string
    type                 = string
  }))
}

variable "load_balancer_az" {
  type = list(string)
  default = ["subnet-public1", "subnet-public2"]
}

locals {
  public_subnets = toset([for value in var.subnet : value.name if value.type == "public"])
  test_az_subnet = [for az in var.load_balancer_az : lookup(var.subnet, az, null)]
}