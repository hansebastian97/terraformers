# output "vpc_resource_name" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc-singapore.vpc_name
# }

output "public_subnet" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc-sydney.public-subnet-name
}

output "public_subnet-map" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc-sydney.public-subnet-map
}

# output "public_subnet" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc-singapore.public-subnet-name
# }

# output "public_subnet-map" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc-singapore.public-subnet-map
# }


# output "local_az_subnet" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.EC2-autoscaling.az
# }

# output "aws_lb_target_group" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.EC2-autoscaling.aws_lb_target_group
# }

# output "aws_autoscaling_group" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.EC2-autoscaling.aws_autoscaling_group
# }