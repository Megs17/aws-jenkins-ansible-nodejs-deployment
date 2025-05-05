resource "aws_eip" "nat_eip" {
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets["public_subnet1"].id
  tags = {
    Name = "nat_gw"
  }
}