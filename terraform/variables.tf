variable "profile" {
  type          = string
  default       = "default"
}

variable "region-common" {
  type          = string
  default       = "us-east-1"
}

variable "external_ip" {
  type          = string
  default       = "0.0.0.0/0"
}

variable "instance_type" {
  type          = string
  default       = "t3.micro"
}

variable "webserver-port" {
  type          = number
  default       = 8080
}