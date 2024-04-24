resource "aws_codedeploy_app" "example" {
  name = "coodesh-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "example" {
  deployment_group_name  = "coodesh-codedeploy-deployment-group"
  app_name               = aws_codedeploy_app.example.name
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  service_role_arn       = var.codedeploy_role_arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "env"
      value = "all"
      type  = "KEY_AND_VALUE"
    }
  }
}


output "codedeploy_app_name" {
  value = aws_codedeploy_app.example.name
}


output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.example.deployment_group_name
}
