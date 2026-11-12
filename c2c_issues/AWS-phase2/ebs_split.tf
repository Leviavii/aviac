resource "aws_ebs_volume" "split" {
  count             = var.enable_costly ? 1 : 0
  availability_zone = var.lab_az
  size              = 1
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs.arn
  tags              = { Rule = "EBS-001", Case = "cmk-defined-in-other-file" }
}
