#Fetching DB subnets

data "aws_subnet_ids" "goldbsubnet" {
    vpc_id                  = aws_vpc.golvpc.id

    filter   {
    name                 = "tag:Name"
    values              = local.db_subnets
    }
}

#Creating DB subnet groups
resource "aws_db_subnet_group" "goldbsubnetgroup" {
    name                = "goldbgroup"
    subnet_ids          =  data.aws_subnet_ids.goldbsubnet.ids

    depends_on = [ 
    aws_route_table.golroutetable,
    aws_route_table_association.private,
    aws_route_table_association.public
     ]
}

# creating DB security group

resource "aws_security_group" "goldbsecuritygroup" {
    name                  = "GOLsecuritygroup" 
    description           = "security group for GOL" 

    tags = {
      Name = "GOLsecurityGroup"
    }

    depends_on = [ 
        aws_db_subnet_group.goldbsubnetgroup
     ]
    
}

resource "aws_db_instance" "" {
  
}