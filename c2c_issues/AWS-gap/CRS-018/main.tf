locals {
  enable_lifecycle_policy = false

  crs018_repositories = {
    app    = { lifecycle_policy = true }
    worker = { lifecycle_policy = false }
  }
}

resource "aws_ecr_repository" "crs018_default" {
  name                 = "c2cgap-crs018-default"
  image_tag_mutability = "MUTABLE"

  tags = {
    Rule = "CRS-018"
  }
}

resource "aws_ecr_repository" "crs018_conditional" {
  name = "c2cgap-crs018-conditional"

  tags = {
    Rule = "CRS-018"
  }
}

resource "aws_ecr_lifecycle_policy" "crs018_conditional_policy" {
  count      = local.enable_lifecycle_policy ? 1 : 0
  repository = aws_ecr_repository.crs018_conditional.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 30 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
      action = {
        type = "expire"
      }
    }]
  })
}

resource "awscc_ecr_repository" "crs018_awscc" {
  repository_name      = "c2cgap-crs018-awscc"
  image_tag_mutability = "MUTABLE"

  tags = [{
    key   = "Rule"
    value = "CRS-018"
  }]
}

resource "aws_ecr_repository" "crs018_foreach" {
  for_each = local.crs018_repositories
  name     = "c2cgap-crs018-foreach-${each.key}"

  tags = {
    Rule = "CRS-018"
  }
}

resource "aws_ecr_lifecycle_policy" "crs018_foreach_policy" {
  for_each   = { for k, v in local.crs018_repositories : k => v if v.lifecycle_policy }
  repository = aws_ecr_repository.crs018_foreach[each.key].name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 30 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 30
      }
      action = {
        type = "expire"
      }
    }]
  })
}
