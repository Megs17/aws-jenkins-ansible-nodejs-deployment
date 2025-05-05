 
resource "aws_instance" "bastion" {
  count = var.ec2_count
 
  ami           = var.list_ec2_configs[count.index].ami 
 
  instance_type = var.list_ec2_configs[count.index].instance_type 
 
  subnet_id     = var.list_ec2_configs[count.index].public == true ? module.network.subnets["public_subnet1"].id: module.network.subnets["private_subnet1"].id
 
  vpc_security_group_ids = var.list_ec2_configs[count.index].public == true ? [ module.network.security_group_allow_ssh_id] : [ module.network.security_group_allow_ssh_port_3000_id] 
 
  associate_public_ip_address = var.list_ec2_configs[count.index].public == true ? true : false
 
  user_data = var.list_ec2_configs[count.index].public == false ? templatefile("user_data.sh", {}) : null

  key_name = var.key_pair_name 
   
  depends_on = [
    module.network.nat_gw 
  ]

  tags = {
    Name = var.list_ec2_configs[count.index].name
  }
  provisioner "local-exec" {
  command = var.list_ec2_configs[count.index].public == true ? "echo The public IP of Bastion is: ${self.public_ip}" : "echo This instance is private and has no public IP ${self.private_ip}"
  }
}








#resource "aws_instance" "bastion" {
#   ami           = "ami-04b4f1a9cf54c11d0"  
#   instance_type = "t2.micro" 
#   subnet_id     = aws_subnet.public_subnet1.id
#   vpc_security_group_ids = [ aws_security_group.allow_ssh.id]  
#   associate_public_ip_address = true
#   tags = {
#     Name = "BastionInstance"
#   }
# }

# resource "aws_instance" "application" {
#   ami           = "ami-04b4f1a9cf54c11d0"  
#   instance_type = "t2.micro"  
#   subnet_id     = aws_subnet.private_subnet1.id
#   vpc_security_group_ids = [ aws_security_group.allow_ssh_port_3000.id]
#   user_data = <<-EOF
#               #!/bin/bash
#               apt-get install -y apache2

#               systemctl start apache2

#               systemctl enable apache2

#               # Create a simple HTML page
#               echo "Hello, World! This is a web server running on Apache." > /var/www/html/index.html
#               EOF

#   tags = {
#     Name = "ApplicationInstance"
#   }
# }
