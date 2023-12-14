# output "subnet_2" {
#   description = "IDs of the VPC's public subnets"
#   value       = [
#     {for key, value in var.subnet : key => value.id if key in var.load_balancer_az}
#   ]
# }