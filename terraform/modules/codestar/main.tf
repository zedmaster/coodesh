resource "aws_codestarconnections_connection" "example" {
  name          = "coodesh-codestar"
  provider_type = "GitHub"
}

output "codestar_connection_arn" {
  value = aws_codestarconnections_connection.example.arn
}
