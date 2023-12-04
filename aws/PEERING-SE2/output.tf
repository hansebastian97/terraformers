output "instance_ip_addr" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.PEERING-SE2-EC2-1.public_ip
}

output "var_region" {
  description = "The public IP address of the EC2 instance"
  value       = var.region

}