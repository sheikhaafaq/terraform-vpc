#------------------>> PROVIDE <<--------------------------
provider "aws" {
    access_key = "${var.myprovider["access_key"]}"
    secret_key = "${var.myprovider["secret_key"]}"
    region     = "${var.myprovider["region"]}"
}

#----------------->> comprinno vpc <<---------------------
module "comprinno-vpc" {
    source                  = "../modules"
    vpc_name                = var.vpc["vpc_name"]
    vpc_cidr                = var.vpc["cidr_block"]
    public_subnet_cidr      = var.subnets["public_subnet_cidr"]
    private_subnet_cidr     = var.subnets["private_subnet_cidr"]
    company                 = var.tags["company"]

}

#--------------->> OUTPUTS <<-------------------------------

output "vpc_id" { value = module.comprinno-vpc.vpc_id }
output "igw_id" { value = module.comprinno-vpc.internet_gateway_id }
output "public-subnet-ids" { value = module.comprinno-vpc.public_subnet_ids }
output "private-subnet-ids" { value = module.comprinno-vpc.private_subnet_ids }