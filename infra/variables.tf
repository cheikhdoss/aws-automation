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

variable "bucket_name" {
  type = string
}

variable "html_object_key" {
  type    = string
  default = "index.html"
}

variable "html_file_path" {
  type = string
}
