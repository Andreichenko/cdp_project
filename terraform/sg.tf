#Create SG for allowing TCP/8080 from all and tcp/22 from some ip in us-east-1
resource "aws_security_group" "jenkins-sg" {
  provider                 = aws.region-common
  name                     = "jenkins-sg"
  description              = "Allow tcp/8080 tcp/22"
  vpc_id                   = aws_vpc.vpc_common.id
  ingress {
    description            = "Allow 22 from our public IP"
    from_port              = 22
    protocol               = "tcp"
    to_port                = 22
    cidr_blocks            = [var.external_ip]
  }
  ingress {
    description            = "Allow anyone on port 8080"
    from_port              = 8080
    protocol               = "tcp"
    to_port                = 8080
    cidr_blocks            = [var.external_ip]
  }

  egress {
    from_port              = 0
    protocol               = "-1"
    to_port                = 0
    cidr_blocks            = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "tomcat-sg" {
  provider                 = aws.region-common
  name                     = "jenkins-sg"
  description              = "Allow tcp/8081 tcp/22"
  vpc_id                   = aws_vpc.vpc_common.id
  ingress {
    description            = "Allow 22 from our public IP"
    from_port              = 22
    protocol               = "tcp"
    to_port                = 22
    cidr_blocks            = [var.external_ip]
  }
  ingress {
    description            = "Allow anyone on port 8081"
    from_port              = 8081
    protocol               = "tcp"
    to_port                = 8081
    cidr_blocks            = [var.external_ip]
  }

  egress {
    from_port              = 0
    protocol               = "-1"
    to_port                = 0
    cidr_blocks            = ["0.0.0.0/0"]
  }
}
