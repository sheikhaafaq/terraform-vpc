# terraform-vpc

Modular Terraform repository to provision a VPC in AWS. By default it will create:

* One public and private subnet
* Internet gateway for the public subnets
* NAT gateway for the private subnets
* One routing table per private subnet associated to the corresponding NAT gateway

Since it is modular it is easy to add or remove modules depending on preferences and requirements.

## Install Terraform

To install `terraform` follow the steps from the install web page [Getting Started](https://www.terraform.io/intro/getting-started/install.html)

## Quick Start

After setting up the binaries go to the cloned terraform directory and create a `.tfvars` file with your AWS IAM API credentials inside the `tf` subdirectory. For example, `provider-credentials.tfvars` with the following content:  
```
myprovider = {
  myprovider.access_key = "<AWS_ACCESS_KEY>"
  myprovider.secret_key = "<AWS_SECRET_KEY>"
  myprovider.region     = "<AWS_EC2_REGION>"
}
```
Replace `<AWS_EC2_REGION>` with the region you want to launch the VPC in.

The global VPC variables are in the `variables.tfvars` file so edit this file and adjust the values accordingly. Replace `TFTEST` with appropriate environment (this value is used to tag all the resources created in the VPC) and set the VPC CIDR in the `vpc.cidr_block` variable (defaults to 10.0.0.0/16).

Each `.tf` file in the `tf` subdirectory is Terraform playbook where our VPC resources are being created. The `variables.tf` file contains all the variables being used and their values are being populated by the settings in the `variables.tfvars`.

To begin, start by issuing the following command inside the `tf` directory:  
```
$ terraform plan -var-file variables.tfvars -var-file provider-credentials.tfvars -out vpc.tfplan
```  
This will create lots of output about the resources that are going to be created and a `vpc.tfplan` plan file containing all the changes that are going to be applied. If this goes without any errors then we can proceed to the next step, otherwise we have to go back and fix the errors terraform has printed out. To apply the planned changes then we run:

```
$ terraform apply -var-file variables.tfvars -var-file provider-credentials.tfvars vpc.tfplan
```  

## Deleting the Infrastructure

To destroy the whole VPC we run:
```
$ terraform destroy -var-file variables.tfvars -var-file provider-credentials.tfvars -force
```