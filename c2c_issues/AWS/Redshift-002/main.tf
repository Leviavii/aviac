# Redshift-002: Redshift cluster publicly accessible
# Misconfiguration: publicly_accessible = true

variable "db_subnet_group_name" {}

resource "aws_redshift_cluster" "redshift002_public" {
  cluster_identifier  = "redshift002-public"
  database_name       = "redshift002db"
  master_username     = "admin"
  master_password     = "Mustbe8Characters!"
  node_type           = "ra3.xlplus"
  cluster_type        = "single-node"
  skip_final_snapshot = true
  # MISCONFIGURATION: publicly accessible
  publicly_accessible = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
