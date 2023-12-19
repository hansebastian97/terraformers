# Module Variable
variable "vpc_name"{
    type = string
}

variable "security_group" {
    type = string
}

# Launch Template Variable
variable "launch_template_availability_zone" {
    type = string
}

variable "vpc_id" {
  type = string
#   sensitive = true
}

# Autoscaling Group Variable
variable "subnet_group" {
  type = list(string)
}

variable "subnet" {
  type = map(object({
    id = string
  }))
}

# Local Variable
locals {
  subnet_map =  ([
    for key in var.subnet_group : 
    var.subnet[key].id
  ])
}