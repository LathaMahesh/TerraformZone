# variable for region

variable "region" {
    type            = string
    default         = "us-west-2"
    description     = "The name of the region"    
  
}


#variable for VPC
variable "vpc_cidr" {
    type            = string
    default         = "192.168.0.0/16" 
    description     = "VPC for aws"
}

#tags for vpc

variable "tags_p" {
    type        = string
    default     = " fterraform"
    description = "tags"
}



#availability zone for subnets
variable "available_zone" {
    type            = list(string)
    default         = ["a" ,"b" ,"c", "a"]
    description     = "subnet available zones"
}

# tags for subnets
variable "tags_subnet" {
    type             = list(string)
    default          = ["web" , "app"]
    description      = " subnet tags" 
  
}