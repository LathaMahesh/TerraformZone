provider "aws" {
    region      = "us-west-2"
}

resource "aws_vpc" "lvpc" {
    cidr_block = "192.168.0.0/16"

    tags = {
      Name = "lathaVpc"
    }
}

resource "aws_subnet" "Web" {
    vpc_id          = aws_vpc.lvpc.id
    cidr_block      = "192.168.1.0/24"
    

    tags = {
      Name = "Web"
    }
}

resource "aws_subnet" "App" {
    vpc_id          = aws_vpc.lvpc.id
    cidr_block      = "192.168.2.0/24"

    tags = {
      Name  = "App"
    }
}