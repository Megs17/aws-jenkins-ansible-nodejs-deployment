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
