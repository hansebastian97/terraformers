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

# variable "public-subnet" {
#   type = map(object({
#     id = string
#   }))
# }

locals {
  public_subnet_name = [for key, value in var.subnet :  value.name if value.type == "public"]

  # public_subnet_map =  tolist([
  #   for key in local.public_subnet_name : 
  #   aws_subnet.Custom-VPC-subnet[key].id
  # ])

  public_subnet_map =  {
    for key in local.public_subnet_name : 
    key => {"id": aws_subnet.Custom-VPC-subnet[key].id}
  }
}