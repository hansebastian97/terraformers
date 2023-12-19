variable "region" {
  type    = string // Declare tipenya
  default = "ap-southeast-1"
}

variable "az" {
  type    = string
  default = "ap-southeast-1a"
}

variable "ami_id" {
  type    = string
  default = "ami-0896ef7bec0d0e792"
}

variable "kms_key" {
  type    = string
  default = "mrk-c2bd3a063f784bc58d0d8b23b7facc77"
}
