provider "aws" {
  profile     = var.profile
  region      = var.region_common
  alias       = "region_common"
}

provider "aws" {
  region  = var.region_common
}
