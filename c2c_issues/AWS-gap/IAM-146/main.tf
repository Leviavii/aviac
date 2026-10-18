resource "aws_iam_role" "iam146_a_root_arn" {
  name = "c2cgap-iam146-a-root-arn"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "arn:aws:iam::306026247677:root" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_b_account_id" {
  name = "c2cgap-iam146-b-account-id"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "306026247677" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_c_aws_wildcard" {
  name = "c2cgap-iam146-c-aws-wildcard"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "*" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_d_principal_star" {
  name = "c2cgap-iam146-d-principal-star"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = "*"
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

data "aws_caller_identity" "iam146_e_caller_root_me" {}

resource "aws_iam_role" "iam146_e_caller_root" {
  name = "c2cgap-iam146-e-caller-root"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.iam146_e_caller_root_me.account_id}:root" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

data "aws_iam_policy_document" "iam146_f_policy_doc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::306026247677:root"]
    }
  }
}

resource "aws_iam_role" "iam146_f_policy_doc" {
  name               = "c2cgap-iam146-f-policy-doc"
  assume_role_policy = data.aws_iam_policy_document.iam146_f_policy_doc_trust.json

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_g_heredoc" {
  name               = "c2cgap-iam146-g-heredoc"
  assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::306026247677:root"
      }
    }
  ]
}
EOT

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_h_array_root" {
  name = "c2cgap-iam146-h-array-root"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = ["arn:aws:iam::306026247677:root"] }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

variable "iam146_i_var_root_account" {
  type    = string
  default = "306026247677"
}

resource "aws_iam_role" "iam146_i_var_root" {
  name = "c2cgap-iam146-i-var-root"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "arn:aws:iam::${var.iam146_i_var_root_account}:root" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}

resource "aws_iam_role" "iam146_j_var_nodefault" {
  name = "c2cgap-iam146-j-var-nodefault"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      }
    ]
  })

  tags = {
    Rule = "IAM-146"
  }
}
