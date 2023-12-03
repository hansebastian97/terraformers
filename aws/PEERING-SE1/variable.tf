variable "region" {
  type    = string // Declare tipenya
  default = "ap-southeast-1"
}

variable "az" {
  type    = string
  default = "ap-southeast-1a"
}

variable "role" {
  type    = string
  default = "arn:aws:iam::084825817586:role/EC2_FullAccess"
}

variable "ami_id" {
  type    = string
  default = "ami-0896ef7bec0d0e792"
}