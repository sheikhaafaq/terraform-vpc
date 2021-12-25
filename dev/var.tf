
variable "myprovider" {
    type    = map
    default = {
        access_key = "unknown"
        secret_key = "unknown"
        region     = "unknown"
    }
}

variable "vpc" {
    type    = map
    default = {
        
        "vpc_name"        = "unknown"
        "cidr_block"      = "unknown"
    }
}

variable "subnets" {
     type    = map
    default = {
    public_subnet_cidr = ["unknown"]
    private_subnet_cidr = ["unknown"]
    }
}
variable "tags" {
     type    = map
    default = {
    "company"         = "unknown"
    }
}