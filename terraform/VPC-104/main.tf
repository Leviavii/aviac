# VPC-104: AMI Block Public Access not enabled
# Misconfiguration: AMI has public launch permission (shared with group = "all")
# This creates a dummy AMI from an EBS snapshot, then makes it publicly accessible.

resource "aws_ebs_volume" "vpc104_volume" {
  availability_zone = "us-east-2a"
  size              = 1

  tags = {
    Name    = "vpc104-dummy-volume"
    Project = "wiz-policy-testing"
  }
}

resource "aws_ebs_snapshot" "vpc104_snapshot" {
  volume_id = aws_ebs_volume.vpc104_volume.id

  tags = {
    Name    = "vpc104-dummy-snapshot"
    Project = "wiz-policy-testing"
  }
}

resource "aws_ami" "vpc104_public_ami" {
  name                = "vpc104-public-ami"
  description         = "Public AMI - triggers VPC-104"
  root_device_name    = "/dev/xvda"
  virtualization_type = "hvm"
  architecture        = "x86_64"

  ebs_block_device {
    device_name           = "/dev/xvda"
    snapshot_id           = aws_ebs_snapshot.vpc104_snapshot.id
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: AMI shared publicly
resource "aws_ami_launch_permission" "vpc104_public_permission" {
  image_id = aws_ami.vpc104_public_ami.id
  group    = "all"
}
