# InstanceGroup-035: ASG launch template with public IP
# Misconfiguration: associate_public_ip_address = true in network_interfaces

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_launch_template" "ig035_public_ip" {
  name          = "ig035-public-ip-lt"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  # MISCONFIGURATION: instances get public IP
  network_interfaces {
    associate_public_ip_address = true
  }
}

resource "aws_autoscaling_group" "ig035_asg" {
  name                = "ig035-public-ip-asg"
  min_size            = 1
  max_size            = 1
  vpc_zone_identifier = [var.subnet_public_a_id]

  launch_template {
    id      = aws_launch_template.ig035_public_ip.id
    version = "$Latest"
  }

  tag {
    key                 = "Project"
    value               = "wiz-policy-testing"
    propagate_at_launch = true
  }
}
