# Creating VPC for us-east-1
resource "aws_vpc" "vpc_common" {
  provider                      = aws.region-common
  cidr_block                    = "10.0.0.0/16"
  enable_dns_hostnames          = true
  enable_dns_support            = true
  tags    = {
    Name                        = "common-vpc-jenkins"
    Owner                       = "Aleksandr Andreichenko"
    Environment                 = "Dev-Test"
    Region                      = "us-east-1"
  }
}

#Create Internet Gateway in us-east-1
resource "aws_internet_gateway" "internet-gateway-common" {
  provider                      = aws.region-common
  vpc_id                        = aws_vpc.vpc_common.id
  tags    = {
    Name                        = "Common IGW"
    Owner                       = "Aleksandr Andreichenko"
    Environmet                  = "Dev-Test"
    Region                      = "us-east-1"
  }
}