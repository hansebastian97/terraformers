# VPC Output
output "vpc_name" {
  description = "Resource name"
  value       = var.vpc_name
  sensitive = true
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.Custom-VPC.id
  sensitive = true
}

output "security_group_id" {
  description = "Security Group"
  value       = aws_security_group.Custom-VPC-SG1.id
  sensitive = true
}

output "subnet" {
  description = "IDs of the VPC's public subnets"
  value       = { for key, value in aws_subnet.Custom-VPC-subnet : key =>  {
      "id": value.id
    }
  }
}

output "public-subnet-name" {
  description = "Security Group"
  value       = local.public_subnet_name
}

output "public-subnet-map" {
  description = "Security Group"
  value       = local.public_subnet_map
}

# var.load_balancer_az
# output "subnet2" {
#   description = "IDs of the VPC's public subnets"
#   value       = {for key, value in aws_subnet.Custom-VPC-subnet: key => 
#     [for subnet_name in var.load_balancer_az :value.id if key ==subnet_name]
    
#   }
# }

# output "subnet2" {
#   description = "IDs of the VPC's public subnets"
#   value       = [for subnet_name in var.load_balancer_az :
#     [for key, value in aws_subnet.Custom-VPC-subnet:  value.id if key == subnet_name]
#   ]
# }





