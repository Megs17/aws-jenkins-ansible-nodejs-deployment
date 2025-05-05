resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = [module.network.subnets["private_subnet1"].id,module.network.subnets["private_subnet2"].id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "megz"
  password             = "AhmedMagdy"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [module.network.security_group_allow_db_sg_id]
}

