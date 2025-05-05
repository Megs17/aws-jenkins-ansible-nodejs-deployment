
## public subnet security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}




### private subnet security group

resource "aws_security_group" "allow_ssh_port_3000" {
  name        = "allow_ssh_port 3000"
  description = "Allow SSH and port 3000 inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = "allow_ssh_port_3000"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_port_ipv4" {
  security_group_id = aws_security_group.allow_ssh_port_3000.id   
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_3000_ipv4" {
  security_group_id = aws_security_group.allow_ssh_port_3000.id   
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_80_ipv4" {
  security_group_id = aws_security_group.allow_ssh_port_3000.id   
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_private_subnet" {
  security_group_id = aws_security_group.allow_ssh_port_3000.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



resource "aws_security_group" "db_sg" {
  name        = "my-db-sg"
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.main_vpc.id


  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-db-sg"
  }
}


resource "aws_security_group" "redis_sg" {
  name        = "redis_sg"
  description = "Security group for Redis"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]  
    from_port   = 6379  
    to_port     = 6379
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]  
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }

  tags = {
    Name = "RedisSG"
  }
}