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

locals {
  public_subnets = toset([for key, value in var.subnet : value.name if value.type == "public"
  ])
}