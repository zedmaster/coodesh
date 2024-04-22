module "networking" {
  source = "./modules/networking"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.networking.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = module.networking.subnet_ids
}

module "auto_scaling" {
  source            = "./modules/auto_scaling"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = module.networking.subnet_ids
}
