output "instance_ip_addr" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.PEERING-SE1-EC2-1.public_ip
}