output "vpc_resource_name" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.resource_name
}

output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.subnet
}