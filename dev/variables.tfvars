
vpc = {
    vpc_name        = "comprinno_vpc"
    cidr_block      = "10.0.0.0/16"
}

subnets = {
    public_subnet_cidr = ["10.0.0.0/24"]
    private_subnet_cidr = ["10.0.1.0/24"]
    }

tags = {
    company         = "comprinno"
    }