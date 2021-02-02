variable "region" {
    type            = string
    default         = "us-west-2"
    description     = "aws region"
  
}

variable "vpccidr" {
    type            = string
    default         = "10.10.0.0/16"
    description     = "cidr for vpc"
  
}

variable "golsubnets" {
    type            = list(string)
    default         = ["web", "db", "app", "db2"]
    description     = "subnets for gol project"  
  
}

variable "golroutetable" {
    type            = list(string)
    default         = ["public" , "private"]
    description     = "route table for gol" 
  
}

variable "golrassociation" {
    type = map

    default = {
        public       = [0]
        private      = [1,2]

    }

}