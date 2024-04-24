resource "aws_codebuild_project" "example" {
  name         = "coodesh-codebuild-project"
  service_role = var.codebuild_role_arn
  artifacts {
    type = "NO_ARTIFACTS"
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
    type            = "GITHUB"
    location        = "https://github.com/${var.github_owner}/${var.github_repo}"
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }
}


output "codebuild_project_name" {
  value = aws_codebuild_project.example.name
}
