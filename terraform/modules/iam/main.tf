resource "aws_iam_role" "pipeline_role" {
  name               = "coodesh-codepipeline-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Environment = "all"
  }
}



resource "aws_iam_policy" "codepipeline_policy" {
  name        = "codepipeline-policy"
  description = "Policy for AWS CodePipeline"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "iam:PassRole"
        ],
        "Resource" : "*",
        "Effect" : "Allow",
        "Condition" : {
          "StringEqualsIfExists" : {
            "iam:PassedToService" : [
              "cloudformation.amazonaws.com",
              "elasticbeanstalk.amazonaws.com",
              "ec2.amazonaws.com",
              "ecs-tasks.amazonaws.com"
            ]
          }
        }
      },
      {
        "Action" : [
          "codecommit:CancelUploadArchive",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetRepository",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:UploadArchive"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "codestar-connections:UseConnection"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "elasticbeanstalk:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "s3:*",
          "sns:*",
          "cloudformation:*",
          "rds:*",
          "sqs:*",
          "ecs:*"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "lambda:InvokeFunction",
          "lambda:ListFunctions"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "opsworks:CreateDeployment",
          "opsworks:DescribeApps",
          "opsworks:DescribeCommands",
          "opsworks:DescribeDeployments",
          "opsworks:DescribeInstances",
          "opsworks:DescribeStacks",
          "opsworks:UpdateApp",
          "opsworks:UpdateStack"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "cloudformation:CreateStack",
          "cloudformation:DeleteStack",
          "cloudformation:DescribeStacks",
          "cloudformation:UpdateStack",
          "cloudformation:CreateChangeSet",
          "cloudformation:DeleteChangeSet",
          "cloudformation:DescribeChangeSet",
          "cloudformation:ExecuteChangeSet",
          "cloudformation:SetStackPolicy",
          "cloudformation:ValidateTemplate"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuildBatches",
          "codebuild:StartBuildBatch"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "devicefarm:ListProjects",
          "devicefarm:ListDevicePools",
          "devicefarm:GetRun",
          "devicefarm:GetUpload",
          "devicefarm:CreateUpload",
          "devicefarm:ScheduleRun"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "servicecatalog:ListProvisioningArtifacts",
          "servicecatalog:CreateProvisioningArtifact",
          "servicecatalog:DescribeProvisioningArtifact",
          "servicecatalog:DeleteProvisioningArtifact",
          "servicecatalog:UpdateProduct"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudformation:ValidateTemplate"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:DescribeImages"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "states:DescribeExecution",
          "states:DescribeStateMachine",
          "states:StartExecution"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "appconfig:StartDeployment",
          "appconfig:StopDeployment",
          "appconfig:GetDeployment"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}


resource "aws_iam_role" "codebuild_role" {
  name               = "coodesh-codebuild-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Environment = "all"
  }
}


resource "aws_iam_policy" "codebuild_policy" {
  name   = "coodesh-codebuild-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:us-east-1:563191627764:log-group:/aws/codebuild/coodesh-codebuild-project",
                "arn:aws:logs:us-east-1:563191627764:log-group:/aws/codebuild/coodesh-codebuild-project:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-us-east-1-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:us-east-1:563191627764:report-group/coodesh*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_iam_role" "codedeploy_role" {
  name               = "coodesh-codedeploy-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Environment = "all"
  }
}


resource "aws_iam_policy" "codedeploy_policy" {
  name        = "coodesh-codedeploy-policy"
  description = "Policy for CodeDeploy Role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "ec2:*",
                "s3:*",
                "elasticloadbalancing:*",
                "cloudwatch:*",
                "autoscaling:*"

            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy_attachment" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = aws_iam_policy.codedeploy_policy.arn
}



output "pipeline_role_arn" {
  value = aws_iam_role.pipeline_role.arn
}

output "aim_codepipeline_role_name" {
  value = aws_iam_role.pipeline_role.name
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_role.arn
}


