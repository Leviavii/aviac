# EBS-007: EBS snapshot block public access unblocked
# Misconfiguration: ebs_snapshot_block_public_access state = "unblocked"

# MISCONFIGURATION: EBS snapshot public access is unblocked
resource "aws_ebs_snapshot_block_public_access" "ebs007_unblocked" {
  state = "unblocked"
}
