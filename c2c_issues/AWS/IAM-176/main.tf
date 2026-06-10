# IAM-176: Public ECR repo policy allows write for all principals
# Misconfiguration: ECR public repo policy grants write actions to all principals
# NOTE: ECR Public is only available in us-east-1

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "iam176_insecure_repo" {
  provider        = aws.us_east_1
  repository_name = "iam176-insecure-repo"

  tags = {
    Project = "wiz-policy-testing"
  }
}

data "aws_iam_policy_document" "iam176_insecure_policy" {
  statement {
    sid    = "PublicWriteAccess"
    effect = "Allow"
    # MISCONFIGURATION: all principals can write
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchDeleteImage"
    ]
  }
}

resource "aws_ecrpublic_repository_policy" "iam176_insecure_policy" {
  provider        = aws.us_east_1
  repository_name = aws_ecrpublic_repository.iam176_insecure_repo.repository_name
  policy          = data.aws_iam_policy_document.iam176_insecure_policy.json
}
