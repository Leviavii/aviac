# RDS-003: DB instance publicly accessible
# Misconfiguration: publicly_accessible = true

variable "db_subnet_group_name" {}

resource "aws_db_instance" "rds003_public" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "rds003-public-instance"
  db_name              = "rds003db"
  username             = "admin"
  password             = "foobarbaz123"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name
  # MISCONFIGURATION: publicly accessible
  publicly_accessible  = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
