output "resource_name" {
  description = "Resource name"
  value       = "${var.vpc_name}"
}

output "subnet" {
  value   = var.subnet
}