# DatabaseServer-042: Lightsail Database publicly accessible
# Misconfiguration: publicly_accessible = true

resource "aws_lightsail_database" "dbserver042_public_db" {
  relational_database_name = "dbserver042-public-db"
  master_database_name     = "masterdb"
  master_username          = "dbadmin"
  master_password          = "Password123!"
  blueprint_id             = "postgres_14"
  bundle_id                = "micro_2_0"
  # MISCONFIGURATION: publicly accessible
  publicly_accessible      = true
  skip_final_snapshot      = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
