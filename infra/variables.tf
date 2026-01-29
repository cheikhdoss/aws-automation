variable "region" {
  default = "us-east-2"
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
  default = "ami-04f34746e5e1ec0fe"
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
