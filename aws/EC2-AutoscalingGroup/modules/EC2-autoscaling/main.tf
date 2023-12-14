# Create Launch Template
resource "aws_launch_template" "Custom-VPC-launch-template" {
  name = "${var.vpc_name}-launch-template"
  instance_type = "t2.micro"
  image_id = data.aws_ami.ubuntu-22-04.image_id
  key_name = "ap-southeast-kp1"
  instance_initiated_shutdown_behavior = "stop"
  
  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [var.launch_template_security_group]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = base64encode(templatefile("${path.module}/data/user-data.sh", {availability_zone = var.launch_template_availability_zone}))
}


# resource "aws_autoscaling_group" "Custom-VPC-group" {
#   name_prefix   = "${var.vpc_name}"
#   max_size                  = 2
#   min_size                  = 2
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 2
#   force_delete              = true
#   vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]
#   # vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

#   launch_template {
#     id = aws_launch_template.Custom-VPC-launch-template.id
#     version = "$Latest"
#   }

#   instance_maintenance_policy {
#     min_healthy_percentage = 90
#     max_healthy_percentage = 120
#   }

# }