# Create EC2
resource "aws_launch_template" "foo" {
  name = "${var.vpc_name}-launch-template"
  instance_type = "t2.micro"
  image_id = data.aws_ami.ubuntu-22-04.image_id
  key_name = "ap-southeast-kp1"
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

  user_data = base64encode(templatefile("${path.module}/data/user-data.sh", {availability_zone = var.availability_zone}))
}