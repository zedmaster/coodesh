resource "aws_codestarconnections_connection" "example" {
  name          = "coodesh-codestar"
  provider_type = "GitHub"
}

resource "aws_iam_policy" "codestar_connection_policy" {
  name        = "codestar-connection-policy"
  description = "Policy for AWS CodeStar Connection to GitHub"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:ListConnections",
          "codestar-connections:GetConnection",
          "codestar-connections:GetHost",
          "codestar-connections:GetInstallationUrl",
          "codestar-connections:UseConnection"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "codestar_connection_attachment" {
  name       = "codestar-connection-attachment"
  policy_arn = aws_iam_policy.codestar_connection_policy.arn
  roles      = [var.aim_codepipeline_role_name]
}

output "codestar_connection_arn" {
  value = aws_codestarconnections_connection.example.arn
}

