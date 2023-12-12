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
  value   = aws_subnet.Custom-VPC-subnet
  sensitive = true
}

output "public_subnets" {
  value = local.public_subnets
  sensitive = true
}