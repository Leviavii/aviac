resource "aws_ssm_parameter" "sc013_plain" {
  name  = "/c2cgap-sc013-plain/app/config/db_host"
  type  = "String"
  value = "db.internal.example.com"

  tags = {
    Rule = "ServiceConfiguration-013"
  }
}

resource "aws_ssm_parameter" "sc013_list" {
  name  = "/c2cgap-sc013-list/app/config/allowed_subnets"
  type  = "StringList"
  value = "${var.subnet_public_a_id},${var.subnet_public_b_id}"

  tags = {
    Rule = "ServiceConfiguration-013"
  }
}

resource "awscc_ssm_parameter" "sc013_cc" {
  name  = "/c2cgap-sc013-cc/app/config/feature_flag"
  type  = "String"
  value = "enabled"

  tags = {
    Project = "wiz-c2c-gap"
    Rule    = "ServiceConfiguration-013"
  }
}

resource "aws_ssm_parameter" "sc013_securedefault" {
  name  = "/c2cgap-sc013-securedefault/app/secret/db_password"
  type  = "SecureString"
  value = "placeholder-password"

  tags = {
    Rule = "ServiceConfiguration-013"
  }
}

resource "aws_ssm_parameter" "sc013_insecure" {
  name           = "/c2cgap-sc013-insecure/app/config/api_endpoint"
  type           = "String"
  insecure_value = "https://api.internal.example.com"

  tags = {
    Rule = "ServiceConfiguration-013"
  }
}
