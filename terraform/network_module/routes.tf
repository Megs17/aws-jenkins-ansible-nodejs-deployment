## public subnet route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
    tags = {
    Name = "public_route_table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id             = aws_internet_gateway.main_gw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = 2
  subnet_id      = count.index == 0 ? aws_subnet.subnets["public_subnet1"].id: aws_subnet.subnets["public_subnet2"].id
  route_table_id = aws_route_table.public_route_table.id
}

## private subnet route table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
    tags = {
    Name = "private_route_table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id 
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.subnets["private_subnet1"].id
  route_table_id = aws_route_table.private_route_table.id
}
