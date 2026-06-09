# EFS-005: EFS without resource policy
# Misconfiguration: no aws_efs_file_system_policy attached

resource "aws_efs_file_system" "efs005_no_policy" {
  creation_token = "efs005-no-policy-token"
  encrypted      = true

  # MISCONFIGURATION: no EFS file system policy is attached to this EFS

  tags = {
    Name    = "efs005-no-policy"
    Project = "wiz-policy-testing"
  }
}
