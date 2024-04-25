resource "aws_codebuild_project" "example" {
  name         = "coodesh-codebuild-project"
  service_role = var.codebuild_role_arn
  artifacts {
    type = "CODEPIPELINE" # Definindo o tipo de artefato como CODEPIPELINE
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "ENV"
      value = "all"
    }
  }

  source {
    type = "CODEPIPELINE" # Definindo o tipo de fonte como CODEPIPELINE
  }
}


output "codebuild_project_name" {
  value = aws_codebuild_project.example.name
}
