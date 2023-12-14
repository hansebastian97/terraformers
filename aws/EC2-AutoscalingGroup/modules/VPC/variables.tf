# Module Variable
variable "vpc_name" {
    type = string
}

variable "cidr_block" {
    type = string
}



variable "subnet" {
  type = map(object({
    name                 = string
    subnet_cidr          = string
    availability_zone    = string
    type                 = string
  }))
}

variable "load_balancer_az" {
  type = list(string)
  default = ["subnet-public1", "subnet-private1"]
}



locals {
  public_subnets = [{for key, value in var.subnet : key => value if value.type == "public"}]
}