resource "aws_vpc" "latvpc" {
    cidr_block         = var.primary_network
    
    tags = {
      Name = "Latterraform"
    }
}

resource "aws_subnet" "subn" {
    vpc_id              = aws_vpc.latvpc.id
    count               = length(var.primary_subnet)
    cidr_block          = cidrsubnet(var.primary_network,8,count.index)

    tags = {
      Name = var.primary_subnet[count.index]
    }
}