# ServiceConfiguration-052: SSM service config public sharing
# Misconfiguration: SSM service setting enables public document sharing
# NOTE: The setting_id must match your account. Update the account ID below.

resource "aws_ssm_service_setting" "svcconfig052_public_sharing" {
  setting_id    = "arn:aws:ssm:us-east-2:306026247677:servicesetting/ssm/documents/console/public-sharing-permission"
  # MISCONFIGURATION: public sharing enabled
  setting_value = "Enable"
}
