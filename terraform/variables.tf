variable "region" {
  type = string
}

variable "list_ec2_configs" {
type = list(object({
  name = string
  ami = string
  instance_type = string
  public = bool
}))  
}

variable "ec2_count" {
    type = number
    default = 1
}
variable "vpc_name" {
  type        = string
  default     = "MainVPC"
}

variable "subnets_list" {
  type        = list(object({
    name = string
    cidr = string
    az   = string
    type = string
  }))
}
variable "key_pair_name" {
  description = "Name of the AWS key pair"
  type        = string
  default = "megskey"
}