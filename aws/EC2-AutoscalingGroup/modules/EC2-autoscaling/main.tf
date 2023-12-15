# Create Launch Template
# resource "aws_launch_template" "Custom-VPC-launch-template" {
#   name = "${var.vpc_name}-launch-template"
#   instance_type = "t2.micro"
#   image_id = data.aws_ami.ubuntu-22-04.image_id
#   key_name = "ap-southeast-kp1"
#   instance_initiated_shutdown_behavior = "stop"
  
#   monitoring {
#     enabled = true
#   }
  
#   vpc_security_group_ids = [var.security_group]

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "test"
#     }
#   }
#   user_data = base64encode(templatefile("${path.module}/data/user-data.sh", {availability_zone = var.launch_template_availability_zone}))
# }

# resource "aws_autoscaling_group" "Custom-VPC-autoscaling-group" {
#   name_prefix   = "${var.vpc_name}-Autoscaling-group"
#   max_size                  = 2
#   min_size                  = 2
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 2
#   force_delete              = true
#   vpc_zone_identifier       = local.subnet_map

#   launch_template {
#     id = aws_launch_template.Custom-VPC-launch-template.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = "instance-"
#     propagate_at_launch = true
#   }

#   instance_maintenance_policy {
#     min_healthy_percentage = 90
#     max_healthy_percentage = 120
#   }
  
# }

resource "aws_lb" "Custom-VPC-lb" {
  name               = "${var.vpc_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = local.subnet_map

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "Custom-VPC-lb-target-group" {
  name     = "${var.vpc_name}-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    path = "/"
  }
}

# resource "aws_lb_target_group_attachment" "test" {
#   for_each = {
#     for k, v in aws_instance.example :
#     v.id => v
#   }

#   target_group_arn = aws_lb_target_group.example.arn
#   target_id        = each.value.id
#   port             = 80
# }
#   target_group_arn = aws_lb_target_group.Custom-VPC-lb-target-group.arn
#   target_id        = aws_instance.test.id
#   port             = 80
# }