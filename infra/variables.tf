variable "region" {
  default = "eu-west-1"
}
variable "ami" {
  type    = string
  default = "ami-01f23391a59163da9"
}
variable "instance_name" {
  default = "Demo-EC2-Instance"
}
variable "instance_size" {
  default = "t2.micro"
}
variable "instance_env" {
  default = "Dev"
}
