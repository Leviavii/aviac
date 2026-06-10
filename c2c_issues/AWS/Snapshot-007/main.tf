# Snapshot-007: DocumentDB snapshot public
# Misconfiguration: snapshot shared with all accounts (public)

resource "aws_docdb_cluster" "snapshot007_cluster" {
  cluster_identifier  = "snapshot007-docdb-cluster"
  master_username     = "wizadmin"
  master_password     = "TestPassword123!"
  skip_final_snapshot = true

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_docdb_cluster_snapshot" "snapshot007_snapshot" {
  db_cluster_identifier          = aws_docdb_cluster.snapshot007_cluster.cluster_identifier
  db_cluster_snapshot_identifier = "snapshot007-public-snap-v2"
}

# MISCONFIGURATION: snapshot shared publicly with all accounts
resource "aws_db_cluster_snapshot" "snapshot007_public_share" {
  db_cluster_identifier          = aws_docdb_cluster.snapshot007_cluster.cluster_identifier
  db_cluster_snapshot_identifier = aws_docdb_cluster_snapshot.snapshot007_snapshot.db_cluster_snapshot_identifier
  shared_accounts                = ["all"]
}
