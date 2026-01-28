variable "region" {
  default = "us-west-1"
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_access_key" {
  type      = string
  sensitive = true
}

variable "ami" {
  type    = string
  default = "ami-0290e60ec230db1e4"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "neosoft-cheikh"
}

variable "instance_size" {
  default = "t2.micro"
}

variable "instance_env" {
  default = "Dev"
}
