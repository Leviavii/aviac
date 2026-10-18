variable "sns_012_passthru_success_role_arn" {
  type    = string
  default = null
}

variable "sns_012_passthru_sample_rate" {
  type    = number
  default = null
}

variable "sns_012_toggle_enable_logging" {
  type    = bool
  default = false
}

resource "aws_sns_topic" "sns_012_default" {
  name = "c2cgap-sns012-default"
  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_sns_topic" "sns_012_failure_only" {
  name                             = "c2cgap-sns012-failure-only"
  lambda_failure_feedback_role_arn = aws_iam_role.sns_012_failure_only_feedback.arn
  sqs_failure_feedback_role_arn    = aws_iam_role.sns_012_failure_only_feedback.arn
  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_iam_role" "sns_012_failure_only_feedback" {
  name = "c2cgap-sns012-failure-only-feedback"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_sns_topic" "sns_012_rate_no_role" {
  name                                = "c2cgap-sns012-rate-no-role"
  sqs_failure_feedback_role_arn       = aws_iam_role.sns_012_rate_no_role_feedback.arn
  sqs_success_feedback_sample_rate    = 100
  lambda_success_feedback_sample_rate = 100
  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_iam_role" "sns_012_rate_no_role_feedback" {
  name = "c2cgap-sns012-rate-no-role-feedback"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_sns_topic" "sns_012_passthru" {
  name                             = "c2cgap-sns012-passthru"
  sqs_success_feedback_role_arn    = var.sns_012_passthru_success_role_arn
  sqs_success_feedback_sample_rate = var.sns_012_passthru_sample_rate
  tags = {
    Rule = "SNS-012"
  }
}

resource "aws_sns_topic" "sns_012_toggle" {
  name                                = "c2cgap-sns012-toggle"
  lambda_success_feedback_role_arn    = var.sns_012_toggle_enable_logging ? "arn:aws:iam::${var.account_id}:role/sns-feedback-role" : null
  lambda_success_feedback_sample_rate = var.sns_012_toggle_enable_logging ? 100 : null
  tags = {
    Rule = "SNS-012"
  }
}

variable "sns_012_modobj_sqs_feedback" {
  type = object({
    failure_role_arn    = optional(string)
    success_role_arn    = optional(string)
    success_sample_rate = optional(number)
  })
  default = {}
}

resource "aws_sns_topic" "sns_012_modobj" {
  name                             = "c2cgap-sns012-modobj"
  sqs_failure_feedback_role_arn    = var.sns_012_modobj_sqs_feedback.failure_role_arn
  sqs_success_feedback_role_arn    = var.sns_012_modobj_sqs_feedback.success_role_arn
  sqs_success_feedback_sample_rate = var.sns_012_modobj_sqs_feedback.success_sample_rate
  tags = {
    Rule = "SNS-012"
  }
}

variable "sns_012_modtry_sqs_feedback" {
  type    = map(string)
  default = {}
}

resource "aws_sns_topic" "sns_012_modtry" {
  name                             = "c2cgap-sns012-modtry"
  sqs_failure_feedback_role_arn    = try(var.sns_012_modtry_sqs_feedback.failure_role_arn, null)
  sqs_success_feedback_role_arn    = try(var.sns_012_modtry_sqs_feedback.success_role_arn, null)
  sqs_success_feedback_sample_rate = try(var.sns_012_modtry_sqs_feedback.success_sample_rate, null)
  tags = {
    Rule = "SNS-012"
  }
}
