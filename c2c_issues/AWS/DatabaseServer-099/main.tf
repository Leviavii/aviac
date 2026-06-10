# DatabaseServer-099: Timestream Influx DB public access
# Misconfiguration: publicly_accessible = true
# NOTE: Timestream InfluxDB may have limited region availability.
# Check if available in your target region.

variable "vpc_id" {}
variable "subnet_public_a_id" {}
variable "subnet_public_b_id" {}

resource "aws_security_group" "dbserver099_sg" {
  name        = "dbserver099-influxdb-sg"
  description = "Security group for Timestream InfluxDB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8086
    to_port     = 8086
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_timestreaminfluxdb_db_instance" "dbserver099_public_influx" {
  name                   = "dbserver099-public-influx"
  allocated_storage      = 20
  bucket                 = "wiz-test-bucket"
  db_instance_type       = "db.influx.medium"
  password               = "SecurePassword123"
  organization           = "wiz-org"
  username               = "admin"
  vpc_security_group_ids = [aws_security_group.dbserver099_sg.id]
  vpc_subnet_ids         = [var.subnet_public_a_id, var.subnet_public_b_id]
  # MISCONFIGURATION: publicly accessible
  publicly_accessible    = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
