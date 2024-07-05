resource "aws_vpc" "terraform"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "terraform"
    }
}
resource "aws_subnet" "subnet_tr"{
    vpc_id = aws_vpc.terraform.id
    availability_zone = ""
}