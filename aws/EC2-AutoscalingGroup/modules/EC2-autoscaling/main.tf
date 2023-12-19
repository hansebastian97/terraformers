# Create Launch Template
resource "aws_launch_template" "Custom-VPC-launch-template" {
  name = "${var.vpc_name}-launch-template"
  instance_type = "t2.micro"
  image_id = data.aws_ami.ubuntu-22-04.image_id
  instance_initiated_shutdown_behavior = "stop"
  
  monitoring {
    enabled = true
  }
  
  vpc_security_group_ids = [var.security_group]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "test"
    }
  }
  user_data = base64encode(templatefile("${path.module}/data/user-data.sh", {availability_zone = var.launch_template_availability_zone}))
}

# Create Load Balancer Target Group
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

# Create Autoscaling Group
resource "aws_autoscaling_group" "Custom-VPC-autoscaling-group" {
  name_prefix   = "${var.vpc_name}-Autoscaling-group"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = local.subnet_map
  launch_template {
    id = aws_launch_template.Custom-VPC-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "instance-"
    propagate_at_launch = true
  }

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
}

# Attach Load Balancer Target Group ke Autoscaling Group
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.Custom-VPC-autoscaling-group.id
  lb_target_group_arn    = aws_lb_target_group.Custom-VPC-lb-target-group.arn
}

# Create Application Load Balancer
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

# Create Load Balancer Listener
resource "aws_lb_listener" "Custom-VPC-lb-listener" {
  load_balancer_arn = aws_lb.Custom-VPC-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Custom-VPC-lb-target-group.arn
  }
}