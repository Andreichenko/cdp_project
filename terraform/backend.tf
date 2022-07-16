terraform {
  required_version    =    ">= 0.12.0"
  required_providers {
    aws = ">=3.0.0"
  }
  backend "s3" {
    region            = "us-east-1"
    profile           = "default"
    key               = "terraform-state-file/statefile.tfstate"
    bucket            = "terraform-state-bucket-frei-0009"
  }
}

#aws s3api create-bucket --bucket terraform-state-bucket-frei-0008