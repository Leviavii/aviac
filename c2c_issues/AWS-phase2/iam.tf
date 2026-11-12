data "aws_caller_identity" "me" {}

locals {
  partner_root = "arn:aws:iam::${var.partner_account_id}:root"
  self_root    = "arn:aws:iam::${data.aws_caller_identity.me.account_id}:root"
}

resource "aws_iam_role" "partner_root" {
  name = "c2c-fam-partner-root"
  tags = { Rule = "IAM-057 IAM-146", Case = "baseline-cross-account" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = local.partner_root }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role" "partner_extid" {
  name = "c2c-fam-partner-extid"
  tags = { Rule = "IAM-057 IAM-146", Case = "negative-external-id" }
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = local.partner_root }
      Action    = "sts:AssumeRole"
      Condition = { StringEquals = { "sts:ExternalId" = "abc123" } }
    }]
  })
}

resource "aws_iam_role" "mfa_bool" {
  name = "c2c-fam-mfa-bool"
  tags = { Rule = "IAM-057 IAM-146", Case = "mfa-boolean" }
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = local.partner_root }
      Action    = "sts:AssumeRole"
      Condition = { Bool = { "aws:MultiFactorAuthPresent" = true } }
    }]
  })
}

resource "aws_iam_role" "orgid" {
  name = "c2c-fam-orgid"
  tags = { Rule = "IAM-057 IAM-146", Case = "principal-org-id" }
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = local.partner_root }
      Action    = "sts:AssumeRole"
      Condition = { StringEquals = { "aws:PrincipalOrgID" = var.org_id } }
    }]
  })
}

resource "aws_iam_role" "same_literal" {
  name = "c2c-fam-same-literal"
  tags = { Rule = "IAM-057 IAM-146", Case = "same-account-literal" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = "arn:aws:iam::306026247677:root" }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role" "bare_partner" {
  name = "c2c-fam-bare-partner"
  tags = { Rule = "IAM-057 IAM-146", Case = "bare-account-id" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = var.partner_account_id }, Action = "sts:AssumeRole" }]
  })
}

data "aws_iam_policy_document" "partner_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [local.partner_root]
    }
  }
}

resource "aws_iam_role" "policy_doc" {
  name               = "c2c-fam-policy-doc"
  tags               = { Rule = "IAM-057 IAM-146", Case = "aws-iam-policy-document" }
  assume_role_policy = data.aws_iam_policy_document.partner_trust.json
}

resource "aws_iam_role" "caller_root" {
  name = "c2c-fam-caller-root"
  tags = { Rule = "IAM-057 IAM-146", Case = "caller-identity-root" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = local.self_root }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role" "local_partner" {
  name = "c2c-fam-local-partner"
  tags = { Rule = "IAM-057 IAM-146", Case = "local-partner-arn" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = local.partner_root }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role" "empty_cond" {
  name = "c2c-fam-empty-cond"
  tags = { Rule = "IAM-057 IAM-146", Case = "empty-condition" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { AWS = local.partner_root }, Action = "sts:AssumeRole", Condition = {} }]
  })
}

resource "aws_iam_role" "single_stmt" {
  name = "c2c-fam-single-stmt"
  tags = { Rule = "IAM-057 IAM-146", Case = "single-object-statement" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = { Effect = "Allow", Principal = { AWS = local.partner_root }, Action = "sts:AssumeRole" }
  })
}

resource "aws_iam_role" "svc" {
  name = "c2c-fam-svc"
  tags = { Rule = "IAM-057 IAM-146 IAM-081", Case = "service-principal" }
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role_policy" "svc_inline" {
  name = "c2c-fam-svc-inline"
  role = aws_iam_role.svc.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Action = "sts:AssumeRole", Resource = "*" }]
  })
}

resource "aws_iam_policy" "p081_lit" {
  name = "c2c-fam-081-lit"
  tags = { Rule = "IAM-081", Case = "assume-any-role" }
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{ Effect = "Allow", Action = "sts:AssumeRole", Resource = "*" }]
  })
}

data "aws_iam_policy_document" "p081_cond" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [var.org_id]
    }
  }
}

resource "aws_iam_policy" "p081_cond" {
  name   = "c2c-fam-081-cond"
  tags   = { Rule = "IAM-081", Case = "negative-with-condition" }
  policy = data.aws_iam_policy_document.p081_cond.json
}

resource "aws_iam_policy" "p081_file" {
  name   = "c2c-fam-081-file"
  tags   = { Rule = "IAM-081", Case = "policy-from-file" }
  policy = file("${path.module}/pol.json")
}
