module "networking" {
  source = "./modules/networking"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.networking.vpc_id
}


module "target_group" {
  source = "./modules/target_group"
  vpc_id = module.networking.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = module.networking.public_subnet_ids
  target_group_arn  = module.target_group.arn
}

module "auto_scaling" {
  source            = "./modules/auto_scaling"
  security_group_id = module.security_group.security_group_id
  subnet_ids        = module.networking.public_subnet_ids
  auto_scaling_arn  = module.alb.arn
  target_group_arn  = module.target_group.arn

  depends_on = [
    module.networking,
    module.security_group,
    module.target_group,
    module.alb
  ]
}
