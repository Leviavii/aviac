# RDS-004: DB instance encryption not enabled
# Misconfiguration: storage_encrypted = false (or not set)

variable "db_subnet_group_name" {}

resource "aws_db_instance" "rds004_unencrypted" {
  allocated_storage    = 10
  db_name              = "rds004db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "rds004-unencrypted"
  username             = "admin"
  password             = "foobarbaz123"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name
  # MISCONFIGURATION: storage encryption disabled
  storage_encrypted    = false

  tags = {
    Project = "wiz-policy-testing"
  }
}
