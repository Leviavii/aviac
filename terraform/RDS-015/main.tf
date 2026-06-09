# RDS-015: RDS PostgreSQL instance vulnerable version
# Misconfiguration: postgres engine with known vulnerable version

variable "db_subnet_group_name" {}

resource "aws_db_instance" "rds015_vulnerable_pg" {
  allocated_storage    = 10
  db_name              = "rds015db"
  engine               = "postgres"
  # MISCONFIGURATION: vulnerable PostgreSQL version
  engine_version       = "14.6"
  instance_class       = "db.t3.micro"
  identifier           = "rds015-vuln-pg-instance"
  username             = "admin"
  password             = "foobarbaz123"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name

  tags = {
    Project = "wiz-policy-testing"
  }
}
