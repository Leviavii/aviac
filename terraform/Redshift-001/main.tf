# Redshift-001: Redshift cluster not encrypted
# Misconfiguration: encrypted not set or set to false

variable "db_subnet_group_name" {}

resource "aws_redshift_cluster" "redshift001_unencrypted" {
  cluster_identifier = "redshift001-unencrypted"
  database_name      = "redshift001db"
  master_username    = "admin"
  master_password    = "Mustbe8Characters!"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  # MISCONFIGURATION: cluster not encrypted
  encrypted          = false
  skip_final_snapshot = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
