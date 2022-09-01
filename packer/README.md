packer for aws image bulder

for test
aws ec2 run-instances --instance-type t2.micro --count 1 --key-name awsprivate.pem --image -id ami-cc228b3

packer build -debug nginx.json
PACKER_LOG=1 packer build -debug nginx.json |& tee debug.txt