variable "github_owner" {
  description = "Owner of the GitHub repository"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "codebuild_role_arn" {
  description = "CodeBuild ARN"
  type        = string
}
