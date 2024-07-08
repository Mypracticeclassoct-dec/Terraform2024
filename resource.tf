# creating the vpc 
resource "aws_vpc" "terraform_vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "terraform"
    }
}
# creating the subnet 
resource "aws_subnet" "subnet_tr"{
    vpc_id = aws_vpc.terraform_vpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/28"
    tags = {
        Name = "terraform"
    }
}
# creating the internet-gatway
resource "aws_internet_gateway" "terraform_intgateway" {
    vpc_id = aws_vpc.terraform_vpc.id 
}
# internet-gateway attachment 
resource "aws_internet_gateway_attachment" "intattch"{
    internet_gateway_id = aws_internet_gateway.terraform_intgateway.id 
    vpc_id = aws_vpc.terraform_vpc.id 
}
# creating the route-table 
resource "aws_route_table" "terraform_rt" {
    vpc_id = aws_vpc.terraform_vpc.id 
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_intgateway.id 
    }
}
# route table association 
resource "aws_route_table_association" "a" {
    route_table_id = aws_route_table.terraform_rt.id 
    subnet_id = aws_subnet.subnet_tr.id 
}
# security group
resource "aws_security_group" "sg_terraform"{
    name = "terraform_sg"
    egress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
    }
    egress {
        from_port = 443
        to_port = 443      
        protocol = "tcp"
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
    tags = {
        Name = "terrafrom"
    }
}
