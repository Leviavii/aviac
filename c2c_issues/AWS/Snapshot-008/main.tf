# Snapshot-008: RDS snapshot public
# Misconfiguration: snapshot shared with all accounts (public)

variable "db_subnet_group_name" {}

resource "aws_db_instance" "snapshot008_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "snapshot008-rds-instance"
  db_name              = "snapshot008db"
  password             = "barbarbarbar"
  username             = "foo"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_db_snapshot" "snapshot008_public_snap" {
  db_instance_identifier = aws_db_instance.snapshot008_rds.identifier
  db_snapshot_identifier = "snapshot008-public-snap"
  # MISCONFIGURATION: snapshot shared with all accounts
  shared_accounts        = ["all"]
}
