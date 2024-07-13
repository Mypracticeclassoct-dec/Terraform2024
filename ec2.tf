# To fetch the ami id from the list of ami in aws to create the ec2 instance resource
data "aws_ami" "machine"{
    most_recent = true
    filter{
        name = "name"
        values = [ "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240701.1" ] # checks the ami name from ami's 
    }
    filter {
      name = "virtualization-type"
      values = [ "hvm" ]  # checks for the virtualization type 
    }
    owners = [ "099720109477" ] # this is the owner-id provided in the ami information it is not the "iam user id"
}
# it displays the ami-id which is fetched from the above data block in the terminal 
output "machineid" {
    value = data.aws_ami.machine.id  
}
# creating the aws instance resource 
resource "aws_instance" "sample" {
    ami = data.aws_ami.machine.id # the ami_id from the data resource
    associate_public_ip_address = true # it will enable the public-ip address
    availability_zone = "us-east-1a"
    instance_type = "t2.micro" # instance family type
    subnet_id = aws_subnet.subnet_tr.id # instance will be created in the subnet you created
    vpc_security_group_ids = [aws_security_group.sg_terraform.id] 
    key_name = "new_key" # To login through the ssh which you created and added as keypairs in your aws account
    tags = {
      "Name" = "terraform" 
    }
    depends_on = [
        aws_vpc.terraform_vpc,
        aws_subnet.subnet_tr
     ]
}
