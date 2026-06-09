# DataWorkflow-012: SSM Document public
# Misconfiguration: permissions shared with account_ids = "All" (public)

resource "aws_ssm_document" "dataworkflow012_public_doc" {
  name            = "dataworkflow012-public-doc"
  document_type   = "Command"
  document_format = "JSON"

  content = jsonencode({
    schemaVersion = "1.2"
    description   = "Public SSM document - triggers DataWorkflow-012"
    parameters    = {}
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "ipConfig"
        inputs = {
          runCommand = ["ifconfig"]
        }
      }
    ]
  })

  # MISCONFIGURATION: document shared publicly
  permissions = {
    type        = "Share"
    account_ids = "All"
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
