provider "aws" {
  profile     = var.profile
  region      = var.region-common
  alias       = "region-common"
  version     = "~> 3.56.0"

}