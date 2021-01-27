variable "primary_region" {
    type                = string
    default             = "us-west-2"
    description         = "aws region"
}

variable "primary_network" {
    type                = string
    default             = "10.10.0.0/16"
    description        = "aws vpc cidr address"
  
}


variable "primary_subnet" {
    type                = list(string)
    default             = ["web" , "app" ,"db" , "mgmt"]
    description         = "aws subnets"
  
}