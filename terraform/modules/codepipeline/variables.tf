variable "s3_bucket" {
  description = "nome do bucket"
  type        = string
}

variable "pipeline_role_arn" {
  description = "Role do pipeline"
  type        = string
}

variable "codebuild_project_name" {
  description = "Nome do codebuild"
  type        = string
}

variable "codedeploy_app_name" {
  description = "CodeDeploy App Name"
  type        = string
}

variable "codedeploy_deployment_group_name" {
  description = "CodeDeploy Group Name"
  type        = string
}

variable "codestar_connection_arn" {
  description = "Codestar arn"
  type        = string
}

variable "github_repository_id" {
  description = "github id"
  type        = string
}
