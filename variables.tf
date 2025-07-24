variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "instance_type" {
  type = string
}
