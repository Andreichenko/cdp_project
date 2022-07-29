provider "aws" {
  profile     = var.profile
  region      = "us-east-1"
  alias       = "region-common"
  version     = "~> 3.56.0"

}