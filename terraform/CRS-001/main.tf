# CRS-001: ECR tag immutability
# Misconfiguration: image_tag_mutability = "MUTABLE" (should be "IMMUTABLE")

resource "aws_ecr_repository" "crs001_mutable_repo" {
  name                 = "crs001-mutable-repo"
  # MISCONFIGURATION: image tags are mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
