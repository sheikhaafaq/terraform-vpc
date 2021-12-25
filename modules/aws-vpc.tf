#--------------------------->> VPC  <<-----------------------------
resource "aws_vpc" "vpc" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_support   = true
    enable_dns_hostnames = true 
    tags                 = {
        Name        = "${var.vpc_name}"
        Company     = "${lower(var.company)}"
    }
}
#--------------------------->> INTERNET-GATEWAY <<----------------------------
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id                 = "${aws_vpc.vpc.id}"
    tags                    = {
        Name        = "${var.vpc_name}-internet-gateway"
        Company     = "${lower(var.company)}"
    }
}



#--------------------------->> PUBLIC SUBNETS <<-------------------------------
resource "aws_subnet" "public-subnet" {  
    count = length( var.public_subnet_cidr )
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = element(var.public_subnet_cidr, count.index)
    availability_zone       = data.aws_availability_zones.azes.names[0]
    tags                    = {
        Name        = "${var.vpc_name}-public-subnet-${count.index}"
        Company     = "${lower(var.company)}"
        }
    }

#--------->> ROUTE TABLE AND PUBLIC ROUTE <<--------------------------
resource "aws_route_table" "public-subnet-rt" {
    vpc_id                  = aws_vpc.vpc.id
    route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.internet-gateway.id
    }
  tags                      = {
    Name            = "${var.vpc_name}-public-subnet-route-table"
    Company         = "${lower(var.company)}"
  }
}

#------------------->> ASSOCIATE PUBLIC SUBNETS TO ROUTE TABLE <<-----------------
resource "aws_route_table_association" "public-rt-ass" {
  count                     = length( var.public_subnet_cidr )
  subnet_id                 = element(aws_subnet.public-subnet.*.id, count.index ) 
  route_table_id            = aws_route_table.public-subnet-rt.id
}



#--------------------------->> PRIVATE SUBNETS <<-------------------------------
resource "aws_subnet" "private-subnet" {  
  count                     = length( var.private_subnet_cidr )
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = element(var.private_subnet_cidr, count.index)
  availability_zone         = data.aws_availability_zones.azes.names[0]
  tags                      = {
    Name            = "${var.vpc_name}-private-subnet-${count.index}"
    Company         = "${lower(var.company)}"
  }
}

#------------------->> ELASTIC IP <<------------
resource "aws_eip" "elastic-ip-1" {
    vpc                      = true
}

#---------------->> NAT GATEWAY <<---------------------
resource "aws_nat_gateway" "nat-gateway-1" {
    allocation_id           = aws_eip.elastic-ip-1.id
    subnet_id               = aws_subnet.public-subnet[0].id 
}


#---------------->> ROUTE TABLE AND PRIVATE ROUTE <<-----------------------
resource "aws_route_table" "private-subnet-rt" {
    vpc_id                  = aws_vpc.vpc.id
    route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-gateway-1.id
    }
    tags                    = {
    Name            = "${var.vpc_name}-private-subnet-route-table"
    Company         = "${lower(var.company)}"
  }
}

#---------------->> ASSOCIATE PRIVATE SUBNETS TO ROUTE TABLE  <<----------
resource "aws_route_table_association" "private-rt-ass"{
  count                     = length( var.private_subnet_cidr )
  subnet_id                 = element(aws_subnet.private-subnet.*.id, count.index ) 
  route_table_id            = aws_route_table.private-subnet-rt.id
}






