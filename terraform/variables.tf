variable "profile" {
  type          = string
  default       = "default"
  description = "The common profile for aws cli"
}

variable "region-common" {
  type          = string
  default       = "us-east-1"
  description = "common region"
}

variable "external_ip" {
  type          = string
  default       = "0.0.0.0/0"
  description = "external ip for instances"
}

variable "instance_type" {
  type          = string
  default       = "t3.micro"
}

variable "webserver-port" {
  type          = number
  default       = 8080
}

variable "vpc_name" {
  description = "The name of the common VPC"
  type        = string
  default     = "The common VPC for EKS"
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block of the common EKS VPC"
  type        = string
  default     = "10.0.0.0/16"
}