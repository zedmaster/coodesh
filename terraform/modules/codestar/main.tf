resource "aws_codestarconnections_connection" "example" {
  name          = "coodesh-codestar"
  provider_type = "GitHub"

  authentication {
    type  = "OAuth"
    token = var.github_token
    host  = "github.com"
    # Insira a seguinte linha se desejar usar um token de GitHub Enterprise
    # enterprise_host = var.github_enterprise_host
  }
}
