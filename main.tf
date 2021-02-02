
# AWS_VPC
resource "aws_vpc" "golvpc" {
    cidr_block      = var.vpccidr

    tags = {
      Name = "gol-vpc"
    }
}

#AWS Subnets
resource "aws_subnet" "golsubnet" {
    vpc_id          = aws_vpc.golvpc.id
    count           = length(var.golsubnets)
    cidr_block      = cidrsubnet(aws_vpc.golvpc.cidr_block,4,count.index)

    tags            = {
            Name = var.golsubnets[count.index]
    }
}

#AWS Internet Gateway
resource "aws_internet_gateway" "golgateway" {
    vpc_id          = aws_vpc.golvpc.id 

    tags            = {
      Name = "GameofLife"
    }
  
}

#aws route table
resource "aws_route_table" "golroutetable" {
   vpc_id                   = aws_vpc.golvpc.id
   count                    = length(var.golroutetable)

    route    {
       cidr_block           = "0.0.0.0/24"
       gateway_id           = aws_internet_gateway.golgateway.id
   }
    tags        = {
            Name    = var.golroutetable[count.index]
        }
    depends_on = [
        aws_vpc.golvpc,
        aws_subnet.golsubnet,
        aws_internet_gateway.golgateway
    ]
  
}

# aws Route table association
resource "aws_route_table_association" "public" {
    count                   = length(local.public_subnets)
    subnet_id               = aws_subnet.golsubnet[local.public_subnets[count.index]].id 
    route_table_id          = aws_route_table.golroutetable[0].id

  
}

resource "aws_route_table_association" "private" {
    count                   = length(local.private_subnets)
    subnet_id               = aws_subnet.golsubnet[local.private_subnets[count.index]].id 
    route_table_id          = aws_route_table.golroutetable[1].id

  
}