locals {
  s3052_topic_arns           = []
  s3052_enable_notifications = false
}

resource "aws_s3_bucket" "s3052_default" {
  bucket = "c2cgap-s3052-default-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket" "s3052_emptycfg" {
  bucket = "c2cgap-s3052-emptycfg-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_emptycfg_notification" {
  bucket = aws_s3_bucket.s3052_emptycfg.id
}

resource "aws_s3_bucket" "s3052_ebfalse" {
  bucket = "c2cgap-s3052-ebfalse-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_ebfalse_notification" {
  bucket      = aws_s3_bucket.s3052_ebfalse.id
  eventbridge = false
}

resource "aws_s3_bucket" "s3052_dynempty" {
  bucket = "c2cgap-s3052-dynempty-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_dynempty_notification" {
  bucket = aws_s3_bucket.s3052_dynempty.id

  dynamic "topic" {
    for_each = local.s3052_topic_arns
    content {
      topic_arn = topic.value
      events    = ["s3:ObjectCreated:*"]
    }
  }
}

resource "aws_s3_bucket" "s3052_toggleoff" {
  bucket = "c2cgap-s3052-toggleoff-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_toggleoff_notification" {
  count       = local.s3052_enable_notifications ? 1 : 0
  bucket      = aws_s3_bucket.s3052_toggleoff.id
  eventbridge = true
}

locals {
  s3052_queue_arns = []
}

resource "aws_s3_bucket" "s3052_modstyle" {
  bucket = "c2cgap-s3052-modstyle-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_modstyle_notification" {
  count  = length(local.s3052_queue_arns) > 0 ? 1 : 0
  bucket = aws_s3_bucket.s3052_modstyle.id

  dynamic "queue" {
    for_each = local.s3052_queue_arns
    content {
      queue_arn = queue.value
      events    = ["s3:ObjectCreated:*"]
    }
  }
}

locals {
  s3052_eventbridge_enabled = false
}

resource "aws_s3_bucket" "s3052_ebvar" {
  bucket = "c2cgap-s3052-ebvar-${var.account_id}"

  tags = {
    Rule = "S3-052"
  }
}

resource "aws_s3_bucket_notification" "s3052_ebvar_notification" {
  bucket      = aws_s3_bucket.s3052_ebvar.id
  eventbridge = local.s3052_eventbridge_enabled
}
