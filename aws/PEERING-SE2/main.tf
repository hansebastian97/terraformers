# Create VPC
resource "aws_vpc" "PEERING-SE2-VPC1" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "PEERING-SE2-VPC1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "PEERING-SE2-IG1" {
  tags = {
    Name = "PEERING-SE2-IG1"
  }
}

# Create Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "PEERING-SE2-VPC1_Attachment" {
  internet_gateway_id = aws_internet_gateway.PEERING-SE2-IG1.id
  vpc_id              = aws_vpc.PEERING-SE2-VPC1.id
}

# Create Security Group
resource "aws_security_group" "PEERING-SE2-SG1" {
  name   = "PEERING-SE2-SG1"
  vpc_id = aws_vpc.PEERING-SE2-VPC1.id

  # Allow HTTP Ingress Rule
  ingress {
    description = "Ingress HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH Ingress Rule
  ingress {
    description = "Ingress SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP Ingress Rule
  ingress {
    description = "Ingress ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.2.0.0/16"]
  }
  egress {
    description = "Egress all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Private Subnet
resource "aws_subnet" "PEERING-SE2-subnet-private1" {
  vpc_id            = aws_vpc.PEERING-SE2-VPC1.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = var.az
  tags = {
    Name = "PEERING-SE2-subnet-private1"
  }
  map_public_ip_on_launch = true
}

# Create Routing Table
resource "aws_route_table" "PEERING-SE2-route-public1" {
  vpc_id = aws_vpc.PEERING-SE2-VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PEERING-SE2-IG1.id
  }
  tags = {
    Name = "PEERING-SE2-route-public1"
  }
}

resource "aws_route_table_association" "PEERING-SE2-route-public1-association" {
  subnet_id      = aws_subnet.PEERING-SE2-subnet-private1.id
  route_table_id = aws_route_table.PEERING-SE2-route-public1.id
}


resource "aws_instance" "PEERING-SE2-EC2-1" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.PEERING-SE2-SG1.id]
  subnet_id              = aws_subnet.PEERING-SE2-subnet-private1.id
  tags = {
    Name = "PEERING-SE2-EC2-1"
  }
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
echo "<html><head><title>Successful connection!</title></head><body><h1 style='color: blue;'>Successful connection!</h1></body></html>" > /var/www/html/index.html
EOF
}