# InstanceGroup-034: ASG launch config not using IMDSv2
# Misconfiguration: http_tokens = "optional" (should be "required")

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_launch_template" "ig034_no_imdsv2" {
  name_prefix   = "ig034-no-imdsv2"
  image_id      = var.ami_id
  instance_type = "t2.micro"

  # MISCONFIGURATION: http_tokens is optional, allowing IMDSv1
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "ig034-no-imdsv2"
      Project = "wiz-policy-testing"
    }
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
