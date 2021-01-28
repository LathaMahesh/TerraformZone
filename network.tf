resource "aws_vpc" "ntier_primary" {
    cidr_block      = var.primary_cidr

    tags   = {
        Name = "fromterraform"
    }  
} 

resource "aws_subnet" "ntier_subnets" {
    vpc_id              =   aws_vpc.ntier_primary.id 
    count               = length(var.subnets)
    cidr_block          = cidrsubnet(aws_vpc.ntier_primary.cidr_block,4,count.index)

    tags = {
      Name = var.subnets[count.index]
    }
}

resource "aws_internet_gateway" "ntier_gateway" {
    vpc_id              = aws_vpc.ntier_primary.id 

    tags = {
      Name = "ntier_internet_gateway"
    }
    depends_on = [ 
        aws_vpc.ntier_primary
     ]
}

resource "aws_route_table" "route_tables" {
    vpc_id              = aws_vpc.ntier_primary.id
    count               = length(var.route_table)

    route {
    cidr_block          = "0.0.0.0/24"
    gateway_id          = aws_internet_gateway.ntier_gateway.id
  }

    tags = {
      Name = var.route_table[count.index]
    }

    depends_on = [ 
        aws_subnet.ntier_subnets,
        aws_internet_gateway.ntier_gateway

     ]
}


resource "aws_route_table_association" "public" {
    count               = length(local.public_subnet)   
    subnet_id           = aws_subnet.ntier_subnets[local.public_subnet[count.index]].id
    route_table_id      = aws_route_table.route_tables[0].id
}

resource "aws_route_table_association" "private" {
  count                 = length(local.public_subnet)
  subnet_id             = aws_subnet.ntier_subnets[local.private_subnet[count.index]].id 
  route_table_id        = aws_route_table.route_tables[1].id
  
}

data "aws_subnet_ids" "dbsubnets" {
  vpc_id               = aws_vpc.ntier_primary.id 

  filter {
    name            = "tag:Name"
    values          = local.db_subnet
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "ntier"
  subnet_ids = data.aws_subnet_ids.dbsubnets.ids

  tags = {
    Name = "ntier DB subnet group"
  }

  depends_on = [ 
    aws_subnet.ntier_subnets,
    aws_route_table_association.public,
    aws_route_table_association.private
   ]
}