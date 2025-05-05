region = "eu-central-1"

vpc_name = "MainVPC"

ec2_count = 2

subnets_list = [ {
    name = "public_subnet1"
    cidr = "10.0.0.0/24"
    az   = "eu-central-1a"
    type = "public"
},
{
    name = "private_subnet1"
    cidr = "10.0.1.0/24"
    az   = "eu-central-1a"
    type = "private"
},
{
    name = "public_subnet2"
    cidr = "10.0.2.0/24"
    az   = "eu-central-1b"
    type = "public"
},
{
    name = "private_subnet2"
    cidr = "10.0.3.0/24"
    az   = "eu-central-1b"
    type = "private"
}
]

list_ec2_configs = [
{
    name = "bastion"
    ami = "ami-07eef52105e8a2059"
    instance_type = "t2.micro"
    public= true
},
{
    name = "application"
    ami = "ami-07eef52105e8a2059"
    instance_type = "t2.micro"
    public = false
}
]



