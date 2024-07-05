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
