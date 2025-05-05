module "network" {
  source = "./network_module"
  vpc_name = var.vpc_name
  subnets_list = var.subnets_list 
}