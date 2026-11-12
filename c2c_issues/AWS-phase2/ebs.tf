resource "aws_ebs_volume" "plain" {
  availability_zone = var.lab_az
  size              = 1
  tags              = { Rule = "EBS-001", Case = "plain-unencrypted" }
}

resource "aws_ebs_snapshot" "plain" {
  volume_id = aws_ebs_volume.plain.id
  tags      = { Rule = "EBS-001", Case = "snapshot-of-unencrypted" }
}

resource "aws_ebs_volume" "var_null" {
  availability_zone = var.lab_az
  size              = 1
  encrypted         = true
  kms_key_id        = var.kms_key_id
  type              = var.vt
  tags              = { Rule = "EBS-001", Case = "var-null-kms-and-type" }
}

data "aws_kms_alias" "ebs" {
  name = "alias/aws/ebs"
}

resource "aws_ebs_volume" "aws_managed" {
  availability_zone = var.lab_az
  size              = 1
  encrypted         = true
  kms_key_id        = data.aws_kms_alias.ebs.target_key_arn
  tags              = { Rule = "EBS-001", Case = "aws-managed-key-via-data" }
}

resource "aws_ebs_volume" "empty_key" {
  availability_zone = var.lab_az
  size              = 1
  encrypted         = true
  kms_key_id        = ""
  tags              = { Rule = "EBS-001", Case = "empty-kms-key" }
}

resource "aws_kms_key" "ebs" {
  description             = "c2c-fam ebs cmk"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags                    = { Rule = "EBS-001", Case = "cmk" }
}

resource "aws_ebs_volume" "cmk" {
  availability_zone = var.lab_az
  size              = 1
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs.arn
  tags              = { Rule = "EBS-001", Case = "negative-cmk" }
}

resource "aws_ebs_snapshot" "cmk" {
  volume_id = aws_ebs_volume.cmk.id
  tags      = { Rule = "EBS-001", Case = "snapshot-of-cmk" }
}

resource "aws_ebs_volume" "restored" {
  availability_zone = var.lab_az
  snapshot_id       = aws_ebs_snapshot.cmk.id
  tags              = { Rule = "EBS-001", Case = "restored-from-encrypted-snapshot" }
}

resource "aws_ebs_volume" "str_false" {
  availability_zone = var.lab_az
  size              = 1
  encrypted         = "false"
  tags              = { Rule = "EBS-001", Case = "encrypted-string-false" }
}

resource "aws_ebs_volume" "io2_ma" {
  count                = var.enable_costly ? 1 : 0
  availability_zone    = var.lab_az
  size                 = 4
  type                 = "io2"
  iops                 = 100
  multi_attach_enabled = true
  encrypted            = true
  tags                 = { Rule = "EBS-001", Case = "io2-multi-attach-aws-managed" }
}
