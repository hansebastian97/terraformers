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
