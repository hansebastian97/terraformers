output "az" {
  description = "Subnet"
  value       = local.subnet_map
}

output "aws_lb_target_group" {
  description = "Load Balancer Target Group"
  value       = aws_lb_target_group.Custom-VPC-lb-target-group
}
