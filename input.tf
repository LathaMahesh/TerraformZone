variable "region" {
    type            = string
    default         = "us-west-2"
    description     = " deafult provider"
  
}

variable "primary_cidr" {
    type            = string
    default         = "10.10.0.0/16"
    description     = "default cidr value"
  
}

variable "subnets" {
    type            = list(string)
    default         = ["web","app","web2","db","db2","mgmt"]
    description     = "default subnets"
  
}

variable "route_table" {
    type            = list(string)
    default         = ["public" , "private"]
    description     = "default route tables" 
}

variable "association" {
    type            = map

    default = {
        public  = [0,2,5]
        private = [1,3,4]
    } 
  
}