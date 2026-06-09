# IDP-002: Cognito identity pool basic flow authentication
# Misconfiguration: allow_classic_flow = true (basic/classic auth flow enabled)

resource "aws_cognito_identity_pool" "idp002_classic_flow" {
  identity_pool_name               = "idp002-classic-flow"
  allow_unauthenticated_identities = false
  # MISCONFIGURATION: classic (basic) authentication flow enabled
  allow_classic_flow               = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
