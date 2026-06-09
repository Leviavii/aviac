# CICDService-013: CodeBuild external PRs without restrictive conditions
# Misconfiguration: webhook uses ACTOR_ACCOUNT_ID blacklist instead of restrictive filter

variable "codebuild_role_arn" {}

resource "aws_codebuild_project" "cicdservice013_unrestricted_pr" {
  name         = "cicdservice013-unrestricted-pr"
  service_role = var.codebuild_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
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

resource "aws_codebuild_webhook" "cicdservice013_webhook" {
  project_name = aws_codebuild_project.cicdservice013_unrestricted_pr.name

  filter_group {
    filter {
      type                    = "EVENT"
      pattern                 = "PULL_REQUEST_CREATED,PULL_REQUEST_UPDATED"
      exclude_matched_pattern = false
    }
    # MISCONFIGURATION: using ACTOR_ACCOUNT_ID blacklist instead of restrictive conditions
    filter {
      type                    = "ACTOR_ACCOUNT_ID"
      pattern                 = "malicious-user"
      exclude_matched_pattern = true
    }
  }
}
