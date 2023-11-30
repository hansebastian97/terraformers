terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
  assume_role {
    role_arn = "arn:aws:iam::084825817586:role/EC2_FullAccess"
  }
}

# Create VPC
resource "aws_vpc" "ap-southeast-2-VPC1" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ap-southeast-2-VPC1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "ap-southeast-2-IG1" {
  vpc_id = aws_vpc.ap-southeast-2-VPC1.id

  tags = {
    Name = "ap-southeast-2-IG1"
  }
}

resource "aws_internet_gateway_attachment" "ap-southeast-2a-VPC2-IG1_Attachment" {
  internet_gateway_id = aws_internet_gateway.ap-southeast-2-IG1.id
  vpc_id              = aws_vpc.ap-southeast-2-VPC1.id
}

resource "aws_security_group" "ap-southeast-2-VPC1-SG1" {
  name   = "sg"
  vpc_id = aws_vpc.ap-southeast-2-VPC1.id

  # Allow HTTP Ingress Rule
  ingress {
    description      = "Ingress HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow SSH Ingress Rule
  ingress {
    description      = "Ingress SSH"
    from_port        = 20
    to_port          = 20
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow ICMP Ingress Rule
  ingress {
    description      = "Ingress ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

}

resource "aws_subnet" "ap-southeast-2a-VPC2-subnet-private1" {
  vpc_id     = aws_vpc.ap-southeast-2-VPC1.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "VPC1-2A-subnet-private1"
  }
}

resource "aws_route_table" "ap-southeast-2a-VPC2-route-public1" {
  vpc_id = aws_vpc.ap-southeast-2-VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ap-southeast-2-IG1.id
  }
  tags = {
    Name = "VPC2-route-public1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ap-southeast-2a-VPC2-subnet-private1.id
  route_table_id = aws_route_table.ap-southeast-2a-VPC2-route-public1.id
}


resource "aws_instance" "test_server" {
  ami           = "ami-02453f5468b897e31"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ap-southeast-2-VPC1-SG1]
  tags = {
    Name = "test_server"
  }
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                service httpd start
                chkconfig httpd on
                echo "<html><head><title>Successful connection!</title></head><body><h1 style='color: blue;'>Successful connection!</h1></body></html>" > /var/www/html/index.html
              EOF
}
