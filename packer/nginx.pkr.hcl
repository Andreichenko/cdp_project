{
  "variables": {
    "aws_access_key": "{{env `AWS_ACCESS_KEY`}}",
    "aws_secret_key": "{{env `AWS_SECRET_KEY`}}"

  },
  "builders": [{
    "type": "amazon-ebs",
    "source_ami_filter": {
      "filters": {
        "virtualization-type": "hvm",
        "root-device-type": "ebs",
        "name":"ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      },
      "owners": ["099720109477"],
      "most_recent": true
    },
    "instance_type": "t2.micro",
    "ssh_username": "ubuntu" ,
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}",
    "ami_name": "mariadb-{{timestamp}}"
  }],
  "provisioners": [{
    "type": "ansible",
    "playbook_file": "ansible/nginx.yml",
    "extra_arguments": ["--extra-vars", "ansible_python_interpreter=/usr/bin/python3","--verbose"]
  }]
}
