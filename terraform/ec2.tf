data "aws_ssm_parameter" "linuxAMI-us-east-1" {
  provider                     = aws.region-common
  name                         = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_ami" "Ubuntu-us-east-1"{
  most_recent = true
  provider = aws.region-common
  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20220610"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]

}

#create key-pair for logging into EC2 in us-east-1
resource "aws_key_pair" "common-key" {
  provider                     = aws.region-common
  public_key                   = file("~/.ssh/id_rsa.pub")
  key_name                     = "jenkins"
}

#create and bootstrap ec2 in us-east-1 jenkins
resource "aws_instance" "jenkins-master-node" {
  provider                     = aws.region-common
  ami                          = data.aws_ssm_parameter.linuxAMI-us-east-1.value
  instance_type                = var.instance_type
  key_name                     = aws_key_pair.common-key.key_name
  associate_public_ip_address  = true
  vpc_security_group_ids       = [aws_security_group.jenkins-sg.id]
  subnet_id                    = aws_subnet.common_subnet_primary.id

  tags = {
    Name                       = "jenkins_master"
  }


  provisioner "local-exec" {
    command                    = <<EOF
aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region-common} --instance-ids ${self.id}
ansible-playbook ansible/jenkins-master.yml -i ansible/inventory/aws_ec2.yml --extra-vars 'hosts=tag_Name_${self.tags.Name}'
EOF
  }
}

#create and bootstrap ec2 in us-east-1 tomcat
resource "aws_instance" "tomcat-server-node" {
  provider                      = aws.region-common
  ami                           = data.aws_ami.Ubuntu-us-east-1.id
  instance_type                 = var.instance_type
  key_name                      = aws_key_pair.common-key.key_name
  associate_public_ip_address   = true
  vpc_security_group_ids        = [aws_security_group.jenkins-sg.id]
  subnet_id                     = aws_subnet.common_subnet_primary.id

  tags = {
    Name                        = "tomcat_server"
  }

  provisioner "local-exec" {
    command                    = <<EOF
aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region-common} --instance-ids ${self.id}
ansible-playbook ansible/tomcat-server.yml -i ansible/inventory/aws_ec2.yml --extra-vars 'hosts=tag_Name_${self.tags.Name}'
EOF
  }
}


