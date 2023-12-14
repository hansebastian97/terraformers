variable "vpc_name"{
    type = string
}

variable "launch_template_availability_zone" {
    type = string
}

variable "launch_template_security_group" {
    type = string
}

variable "load_balancer_az" {
  type = list(string)
  default = ["subnet-public1", "subnet-private1"]
}

# variable "subnet" {
#   type = list(object{

#   })
# }


# locals {
#   vpc_identifier = [for name in var.load_balancer_az : lookup(var.subnet[name], "name", null)]
# }