variable "connection_name" {
  description = "Nome da conexão CodeStar"
  type        = string
}

variable "github_token" {
  description = "Token de acesso do GitHub"
  type        = string
}

variable "aim_codepipeline_role_name" {
  description = "Token de acesso do GitHub"
  type        = string
}


# Descomente e insira se desejar usar um token de GitHub Enterprise
# variable "github_enterprise_host" {
#   description = "Host do GitHub Enterprise"
#   type        = string
# }
