# IDP-001: Cognito identity pool unauthenticated guest access
# Misconfiguration: allow_unauthenticated_identities = true

resource "aws_cognito_identity_pool" "idp001_unauth_pool" {
  identity_pool_name               = "idp001-unauth-pool"
  # MISCONFIGURATION: unauthenticated identities allowed
  allow_unauthenticated_identities = true
  allow_classic_flow               = false

  tags = {
    Project = "wiz-policy-testing"
  }
}
