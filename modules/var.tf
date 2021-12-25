#--------------------------->> VARIABLES <<-------------------------------
data "aws_availability_zones" "azes" {
    state = "available"
}
variable "myprovider" {
    type    = map
    default = {
        access_key = "unknown"
        secret_key = "unknown"
        region     = "unknown"
    }
}
variable "vpc_name" { 
    type = string
    default = "vpc" 
}
variable "company" {
    type = string
}
    
variable "vpc_cidr"   {
    type = string
}
variable "public_subnet_cidr" {
    type = list
}
variable "private_subnet_cidr" {
    type = list   
}

