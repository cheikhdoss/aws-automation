variable "region" {
  default = "us-west-1"
}

variable "access_key" {
  default = "AKIA2OAJT457T7KWMEUJ"
}

variable "secret_access_key" {
  default = "1jZFnCH935Ozpa4EOco/Y9sDbVJvFIgZCr+aSE4e"
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
