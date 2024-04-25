variable "github_owner" {
  description = "Owner of the GitHub repository"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "github_token" {
  description = "OAuth token for GitHub authentication"
  type        = string
}

variable "s3_bucket" {
  description = "nome do bucket"
  type        = string
}

variable "github_repository_id" {
  description = "GitHub ID"
  type        = string
}
