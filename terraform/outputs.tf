output "aws_common_subnet_primary" {
  value = aws_subnet.common_subnet_primary.id
}

output "internet-gateway-common" {
  value = aws_internet_gateway.internet-gateway-common.id
}

output "vpc_common" {
  value = aws_vpc.vpc_common.cidr_block
}

output "jenkins-master-node-public-ip" {
  value = aws_instance.jenkins-master-node.public_ip
}

output "tomcat-server-node-public-ip" {
  value = aws_instance.tomcat-server-node.public_ip
}

