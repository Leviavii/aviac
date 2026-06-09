# CICDService-005: CodeBuild with cleartext credentials
# Misconfiguration: environment variables with credentials stored as PLAINTEXT

variable "codebuild_role_arn" {}

resource "aws_codebuild_project" "cicdservice005_cleartext_creds" {
  name         = "cicdservice005-cleartext-creds"
  description  = "CodeBuild project with cleartext credentials"
  service_role = var.codebuild_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # MISCONFIGURATION: Credentials stored as PLAINTEXT
    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      value = "AKIAIOSFODNN7EXAMPLE"
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      value = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/mitchellh/packer.git"
    git_clone_depth = 1
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
