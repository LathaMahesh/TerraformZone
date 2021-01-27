#VPC
resource "aws_vpc" "lvpc" {
    cidr_block      = var.vpc_cidr

    tags = {
      Name = var.tags_p
    }
}

#Subnets
resource "aws_subnet" "Web" {
    vpc_id               = aws_vpc.lvpc.id
    cidr_block           = cidrsubnet(var.vpc_cidr,8,1)
    availability_zone    = format("%s%s",var.region,var.available_zone[0])

    tags = {
      Name = var.tags_subnet[0]  
      }
}

resource "aws_subnet" "App" {
    vpc_id              = aws_vpc.lvpc.id
    cidr_block          =  cidrsubnet(var.vpc_cidr,8,2)
    availability_zone   =  format("%s%s",var.region,var.available_zone[1])

    tags = {
      Name  = var.tags_subnet[1]
    }
}