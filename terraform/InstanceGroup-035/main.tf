# InstanceGroup-035: ASG launch config with public IP
# Misconfiguration: associate_public_ip_address = true

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_launch_configuration" "ig035_public_ip" {
  name                        = "ig035-public-ip-lc"
  image_id                    = var.ami_id
  instance_type               = "t3.micro"
  # MISCONFIGURATION: instances get public IP
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "ig035_asg" {
  name                 = "ig035-public-ip-asg"
  launch_configuration = aws_launch_configuration.ig035_public_ip.name
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier  = [var.subnet_public_a_id]

  tag {
    key                 = "Project"
    value               = "wiz-policy-testing"
    propagate_at_launch = true
  }
}
