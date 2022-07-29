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
//
//output "cluster_id" {
//  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready."
//  value       = local.cluster_id
//
//  # So that calling plans wait for the cluster to be available before attempting to use it.
//  # There is no need to duplicate this datasource
//  depends_on = [data.http.wait_for_cluster]
//}
//
//output "cluster_arn" {
//  description = "The Amazon Resource Name (ARN) of the cluster."
//  value       = local.cluster_arn
//}

