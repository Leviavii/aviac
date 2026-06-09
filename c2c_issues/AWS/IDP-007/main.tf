# IDP-007: Cognito User Pool WAF not enabled
# Misconfiguration: no WAF Web ACL association on the user pool

resource "aws_cognito_user_pool" "idp007_no_waf" {
  name = "idp007-no-waf-pool"

  # MISCONFIGURATION: no WAF Web ACL association

  tags = {
    Project = "wiz-policy-testing"
  }
}
