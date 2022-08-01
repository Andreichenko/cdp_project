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

#Create subnet for common VPC
resource "aws_subnet" "common_subnet_primary" {
  provider                      = aws.region-common
  cidr_block                    = "10.0.1.0/24"
  availability_zone             = element(data.aws_availability_zones.azs.names, 0)
  vpc_id                        = aws_vpc.vpc_common.id
  tags          = {
    Name                        = "Common subnet primary"
    Owner                       = "Aleksandr Andreichenko"
    Environmet                  = "Dev-Test"
    Region                      = "us-east-1"
  }
}

data "aws_availability_zones" "azs" {
  provider                      = aws.region-common
  state                         = "available"
}

#Create route table in east
resource "aws_route_table" "internet_route" {
  provider                      = aws.region-common
  vpc_id                        = aws_vpc.vpc_common.id
  route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway-common.id
  }

  lifecycle {
    ignore_changes              = all
  }
  tags        = {
    Name                        = "Common-Regionr-Route-table"
  }
}

#Owerwrite default route table of VPC common with our route table entries
resource "aws_main_route_table_association" "set-common-worker-rt-associate" {
  route_table_id                = aws_route_table.internet_route.id
  vpc_id                        = aws_vpc.vpc_common.id
  provider                      = aws.region-common
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