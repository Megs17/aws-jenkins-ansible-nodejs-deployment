# Purpose: Create subnets in the VPC
resource "aws_subnet" "subnets" {
  for_each = {for subnet in var.subnets_list : subnet.name => subnet}
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name = each.value.name
  }
}



# resource "aws_subnet" "public_subnet1" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = "10.0.0.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "public_subnet1"
#   }
# }

# resource "aws_subnet" "private_subnet1" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
  
#   tags = {
#     Name = "private_subnet1"
#   }
# }