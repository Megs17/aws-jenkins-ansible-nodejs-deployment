output "subnets" {
  value = aws_subnet.subnets
}

output "security_group_allow_ssh_id" {
  value = aws_security_group.allow_ssh.id
  
}

output "security_group_allow_ssh_port_3000_id" {
  value = aws_security_group.allow_ssh_port_3000.id  
  
}

output "security_group_allow_db_sg_id" {
  value = aws_security_group.db_sg.id
  
  
}

output "security_group_redis_sg_id" {
    value = aws_security_group.redis_sg.id
  
}
output "nat_gw" {
    value = aws_nat_gateway.nat_gw
  
}

