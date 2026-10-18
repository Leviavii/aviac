locals {
  enable_rotation = false
  rotation_rules  = jsondecode(var.account_id != "" ? "{}" : "{}")
}

resource "aws_secretsmanager_secret" "sec002_default" {
  name                    = "c2cgap-secret002-default"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-002"
  }
}

resource "aws_secretsmanager_secret" "sec002_condrot" {
  name                    = "c2cgap-secret002-condrot"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-002"
  }
}

data "archive_file" "sec002_condrot_rotator_zip" {
  type        = "zip"
  output_path = "${path.module}/sec002_condrot_rotator.zip"

  source {
    content  = "def handler(event, context):\n    return {}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "sec002_condrot_rotator" {
  function_name    = "c2cgap-secret002-condrot-rotator"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.sec002_condrot_rotator_zip.output_path
  source_code_hash = data.archive_file.sec002_condrot_rotator_zip.output_base64sha256

  tags = {
    Rule = "Secret-002"
  }
}

resource "aws_lambda_permission" "sec002_condrot_rotator_invoke" {
  statement_id   = "AllowSecretsManagerInvoke"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.sec002_condrot_rotator.function_name
  principal      = "secretsmanager.amazonaws.com"
  source_account = var.account_id
}

resource "aws_secretsmanager_secret_rotation" "sec002_condrot_rotation" {
  count               = local.enable_rotation ? 1 : 0
  secret_id           = aws_secretsmanager_secret.sec002_condrot.id
  rotation_lambda_arn = aws_lambda_function.sec002_condrot_rotator.arn

  rotation_rules {
    automatically_after_days = 30
  }

  depends_on = [aws_lambda_permission.sec002_condrot_rotator_invoke]
}

resource "aws_secretsmanager_secret" "sec002_modstyle" {
  count                   = 1
  name                    = "c2cgap-secret002-modstyle"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-002"
  }
}

data "archive_file" "sec002_modstyle_rotator_zip" {
  type        = "zip"
  output_path = "${path.module}/sec002_modstyle_rotator.zip"

  source {
    content  = "def handler(event, context):\n    return {}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "sec002_modstyle_rotator" {
  function_name    = "c2cgap-secret002-modstyle-rotator"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.sec002_modstyle_rotator_zip.output_path
  source_code_hash = data.archive_file.sec002_modstyle_rotator_zip.output_base64sha256

  tags = {
    Rule = "Secret-002"
  }
}

resource "aws_lambda_permission" "sec002_modstyle_rotator_invoke" {
  statement_id   = "AllowSecretsManagerInvoke"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.sec002_modstyle_rotator.function_name
  principal      = "secretsmanager.amazonaws.com"
  source_account = var.account_id
}

resource "aws_secretsmanager_secret_rotation" "sec002_modstyle_rotation" {
  count               = local.enable_rotation ? 1 : 0
  secret_id           = aws_secretsmanager_secret.sec002_modstyle[0].id
  rotation_lambda_arn = aws_lambda_function.sec002_modstyle_rotator.arn

  dynamic "rotation_rules" {
    for_each = [local.rotation_rules]

    content {
      automatically_after_days = try(rotation_rules.value.automatically_after_days, null)
      schedule_expression      = try(rotation_rules.value.schedule_expression, null)
    }
  }

  depends_on = [aws_lambda_permission.sec002_modstyle_rotator_invoke]
}

resource "aws_secretsmanager_secret" "sec002_foreach" {
  for_each                = toset(["db", "api"])
  name                    = "c2cgap-secret002-foreach-${each.key}"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-002"
  }
}

data "archive_file" "sec002_foreach_rotator_zip" {
  type        = "zip"
  output_path = "${path.module}/sec002_foreach_rotator.zip"

  source {
    content  = "def handler(event, context):\n    return {}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "sec002_foreach_rotator" {
  function_name    = "c2cgap-secret002-foreach-rotator"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.sec002_foreach_rotator_zip.output_path
  source_code_hash = data.archive_file.sec002_foreach_rotator_zip.output_base64sha256

  tags = {
    Rule = "Secret-002"
  }
}

resource "aws_lambda_permission" "sec002_foreach_rotator_invoke" {
  statement_id   = "AllowSecretsManagerInvoke"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.sec002_foreach_rotator.function_name
  principal      = "secretsmanager.amazonaws.com"
  source_account = var.account_id
}

resource "aws_secretsmanager_secret_rotation" "sec002_foreach_rotation" {
  secret_id           = aws_secretsmanager_secret.sec002_foreach["db"].id
  rotation_lambda_arn = aws_lambda_function.sec002_foreach_rotator.arn

  rotation_rules {
    automatically_after_days = 30
  }

  depends_on = [aws_lambda_permission.sec002_foreach_rotator_invoke]
}

resource "aws_secretsmanager_secret" "sec002_cnt" {
  count                   = 2
  name                    = "c2cgap-secret002-cnt-${count.index}"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-002"
  }
}

data "archive_file" "sec002_cnt_rotator_zip" {
  type        = "zip"
  output_path = "${path.module}/sec002_cnt_rotator.zip"

  source {
    content  = "def handler(event, context):\n    return {}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "sec002_cnt_rotator" {
  function_name    = "c2cgap-secret002-cnt-rotator"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.sec002_cnt_rotator_zip.output_path
  source_code_hash = data.archive_file.sec002_cnt_rotator_zip.output_base64sha256

  tags = {
    Rule = "Secret-002"
  }
}

resource "aws_lambda_permission" "sec002_cnt_rotator_invoke" {
  statement_id   = "AllowSecretsManagerInvoke"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.sec002_cnt_rotator.function_name
  principal      = "secretsmanager.amazonaws.com"
  source_account = var.account_id
}

resource "aws_secretsmanager_secret_rotation" "sec002_cnt_rotation" {
  secret_id           = aws_secretsmanager_secret.sec002_cnt[0].id
  rotation_lambda_arn = aws_lambda_function.sec002_cnt_rotator.arn

  rotation_rules {
    automatically_after_days = 30
  }

  depends_on = [aws_lambda_permission.sec002_cnt_rotator_invoke]
}

resource "awscc_secretsmanager_secret" "sec002_awscc_default" {
  name = "c2cgap-secret002-awscc-default"

  tags = [{
    key   = "Rule"
    value = "Secret-002"
  }]
}
