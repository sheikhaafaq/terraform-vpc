output "vpc_id" { value = aws_vpc.vpc.id }
output "internet_gateway_id" { value = aws_internet_gateway.internet-gateway.id }
output "public_subnet_ids" { value = aws_subnet.public-subnet.*.id }
output "private_subnet_ids" { value = aws_subnet.private-subnet.*.id }
