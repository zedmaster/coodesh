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


module "iam" {
  source = "./modules/iam"
}

module "codestar" {
  source                     = "./modules/codestar"
  connection_name            = ""
  github_token               = var.github_token
  aim_codepipeline_role_name = module.iam.aim_codepipeline_role_name
}

module "codebuild" {
  source             = "./modules/codebuild"
  github_owner       = var.github_owner
  github_repo        = var.github_repo
  codebuild_role_arn = module.iam.codebuild_role_arn
}
module "codedeploy" {
  source              = "./modules/codedeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
}

module "codepipeline" {
  source                           = "./modules/codepipeline"
  github_owner                     = var.github_owner
  github_repo                      = var.github_repo
  github_token                     = var.github_token
  github_repository_id             = var.github_repository_id
  s3_bucket                        = var.s3_bucket
  pipeline_role_arn                = module.iam.pipeline_role_arn
  codebuild_project_name           = module.codebuild.codebuild_project_name
  codedeploy_app_name              = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name = module.codedeploy.codedeploy_deployment_group_name
  codestar_connection_arn          = module.codestar.codestar_connection_arn
}
