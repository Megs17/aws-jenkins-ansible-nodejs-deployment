region = "us-east-1"

vpc_name = "MainVPC"

subnets_list = [ {
    name = "public_subnet1"
    cidr = "10.0.0.0/24"
    az   = "us-east-1a"
    type = "public"
},
{
    name = "private_subnet1"
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
    type = "private"
},
{
    name = "public_subnet2"
    cidr = "10.0.2.0/24"
    az   = "us-east-1b"
    type = "public"
},
{
    name = "private_subnet2"
    cidr = "10.0.3.0/24"
    az   = "us-east-1b"
    type = "private"
}
]

list_ec2_configs = [
{
    name = "bastion"
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    public= true
},
{
    name = "application"
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    public = false
}
]

ec2_count = 2


