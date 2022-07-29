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

output "docker-server-node-public-ip" {
  value = aws_instance.docker-server-node.public_ip
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks.cluster_endpoint
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = module.eks.cluster_status
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}


