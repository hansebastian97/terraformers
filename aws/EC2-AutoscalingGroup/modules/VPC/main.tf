# Create VPC
resource "aws_vpc" "Custom-VPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
    depends_on = [ aws_internet_gateway.Custom-VPC-IG1 ]
}

# Create Internet Gateway
resource "aws_internet_gateway" "Custom-VPC-IG1" {
  tags = {
    Name = "${var.vpc_name}-IG1"
  }

}

# Create Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "Custom-VPC-IG1-Attachment" {
  internet_gateway_id = aws_internet_gateway.Custom-VPC-IG1.id
  vpc_id              = aws_vpc.Custom-VPC.id
  depends_on = [  aws_vpc.Custom-VPC, aws_internet_gateway.Custom-VPC-IG1 ]
}

# Create Security Group
resource "aws_security_group" "Custom-VPC-SG1" {
  name   = "${var.vpc_name}-SG1"
  vpc_id = aws_vpc.Custom-VPC.id

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
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Egress all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Subnet
resource "aws_subnet" "Custom-VPC-subnet" {
  for_each = {for subnet in var.subnet : subnet.name => subnet}

  vpc_id            = aws_vpc.Custom-VPC.id
  cidr_block        = each.value.subnet_cidr
  availability_zone = each.value.availability_zone
  tags = {
      Name = "${var.vpc_name}-${each.value.name}"
  }
  map_public_ip_on_launch = true
  depends_on = [ aws_vpc.Custom-VPC ,aws_route_table.Custom-VPC-route-public1 ]
}

# Create Routing Table
resource "aws_route_table" "Custom-VPC-route-public1" {
  vpc_id = aws_vpc.Custom-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Custom-VPC-IG1.id
  }
  tags = {
    Name = "${var.vpc_name}-route-public1"
  }
  depends_on = [ aws_vpc.Custom-VPC ]
}


resource "aws_route_table_association" "Custom-VPC-route-table-association" {
  for_each = local.public_subnet_map

  subnet_id      = each.value.id
  route_table_id = aws_route_table.Custom-VPC-route-public1.id
  depends_on = [ aws_vpc.Custom-VPC ]
}
