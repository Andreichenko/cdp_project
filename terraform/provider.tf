provider "aws" {
  profile     = var.profile
  region      = var.region-common
  alias       = "region-common"
}

provider "aws" {
  version = "~> 3.56.0"
  region  = "us-east-1"
}
