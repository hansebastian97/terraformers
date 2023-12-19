variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "az" {
  type    = string
  default = "ap-southeast-2a"
}

variable "ami_id" {
  type    = string
  default = "ami-0df4b2961410d4cff"
}

variable "kms_key" {
  type    = string
  default = "mrk-c2bd3a063f784bc58d0d8b23b7facc77"
}
