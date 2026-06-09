# RDS-014: RDS PostgreSQL cluster vulnerable version
# Misconfiguration: aurora-postgresql engine_version with known vulnerable version
# CVE-2023-39417 affects PostgreSQL < 14.9, < 15.4, < 16.0
# Aurora PostgreSQL 9.6.x is also vulnerable (EOL)

resource "aws_rds_cluster" "rds014_vulnerable_cluster" {
  cluster_identifier      = "rds014-vuln-pg-cluster"
  engine                  = "aurora-postgresql"
  # MISCONFIGURATION: vulnerable PostgreSQL version
  engine_version          = "14.6"
  master_username         = "admin"
  master_password         = "mustbeeightchars"
  skip_final_snapshot     = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
