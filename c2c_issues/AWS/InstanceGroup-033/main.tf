# InstanceGroup-033: ASG launch template metadata hop limit
# Misconfiguration: http_put_response_hop_limit > 1

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_launch_template" "ig033_high_hop_limit" {
  name          = "ig033-high-hop-limit"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  # MISCONFIGURATION: hop limit > 1 allows metadata access from containers
  metadata_options {
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
  }
}

resource "aws_autoscaling_group" "ig033_asg" {
  name                = "ig033-asg-hop-limit"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = [var.subnet_public_a_id]

  launch_template {
    id      = aws_launch_template.ig033_high_hop_limit.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = "wiz-policy-testing"
    propagate_at_launch = true
  }
}
