# output "vpc_resource_name" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc.resource_name
# }

# output "vpc_subnets" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc-singapore.subnet
# }

output "subnet2" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc-singapore.subnet2
}



# output "local_az_subnet" {
#   description = "IDs of the VPC's public subnets"
#   value       = module.vpc-singapore.test_az_subnet
# }

# output "ami" {
#   description = "AMI"
#   value = data.aws_ami.ubuntu-22-04.image_id
# }