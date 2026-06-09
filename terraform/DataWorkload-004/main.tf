# DataWorkload-004: DMS Replication Instance publicly accessible
# Misconfiguration: publicly_accessible = true

variable "vpc_id" {}
variable "subnet_public_a_id" {}
variable "subnet_public_b_id" {}

resource "aws_dms_replication_subnet_group" "dataworkload004_subnet_group" {
  replication_subnet_group_id          = "dataworkload004-subnet-group"
  replication_subnet_group_description = "DMS replication subnet group"
  subnet_ids                           = [var.subnet_public_a_id, var.subnet_public_b_id]

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_dms_replication_instance" "dataworkload004_public_dms" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  multi_az                     = false
  # MISCONFIGURATION: publicly accessible
  publicly_accessible          = true
  replication_instance_class   = "dms.t2.micro"
  replication_instance_id      = "dataworkload004-public-dms"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dataworkload004_subnet_group.id

  tags = {
    Project = "wiz-policy-testing"
  }
}
