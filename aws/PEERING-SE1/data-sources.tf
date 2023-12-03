# data-sources.tf

# provider "aws" {
#   region = var.region
# }


# data "aws_ami" "latest_amazon_linux" {
#   most_recent = true 
#   owners = ["099720109477"]

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name = "description"
#     values = ["Canonical, Ubuntu, 22.04 LTS*"]
#   }

# }