# CICDService-014: CodeBuild external PRs with non-anchored conditions
# Misconfiguration: FILE_PATH filter uses non-anchored regex pattern

variable "codebuild_role_arn" {}

resource "aws_codebuild_project" "cicdservice014_unanchored" {
  name         = "cicdservice014-unanchored-filter"
  service_role = var.codebuild_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/example/repo.git"
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_codebuild_webhook" "cicdservice014_webhook" {
  project_name = aws_codebuild_project.cicdservice014_unanchored.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED"
    }
    # MISCONFIGURATION: FILE_PATH filter with non-anchored regex
    filter {
      type    = "FILE_PATH"
      pattern = "src/.*"
    }
  }
}
