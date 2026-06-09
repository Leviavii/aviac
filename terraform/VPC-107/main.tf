# VPC-107: AMI share settings allow public access
# Misconfiguration: AMI launch permission set to group = "all"

resource "aws_ebs_volume" "vpc107_volume" {
  availability_zone = "us-east-2a"
  size              = 1

  tags = {
    Name    = "vpc107-dummy-volume"
    Project = "wiz-policy-testing"
  }
}

resource "aws_ebs_snapshot" "vpc107_snapshot" {
  volume_id = aws_ebs_volume.vpc107_volume.id

  tags = {
    Name    = "vpc107-dummy-snapshot"
    Project = "wiz-policy-testing"
  }
}

resource "aws_ami" "vpc107_public_ami" {
  name                = "vpc107-public-ami"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"

  ebs_block_device {
    device_name = "/dev/sda1"
    snapshot_id = aws_ebs_snapshot.vpc107_snapshot.id
    volume_size = 8
  }

  tags = {
    Name    = "vpc107-public-ami"
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: AMI shared publicly
resource "aws_ami_launch_permission" "vpc107_public_permission" {
  image_id = aws_ami.vpc107_public_ami.id
  group    = "all"
}
