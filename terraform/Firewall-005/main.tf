variable "vpc_id" {}

resource "aws_security_group" "wiz_firewall_005" {
  name        = "wiz-firewall-005-sg"
  description = "Misconfigured SG for Firewall-005"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name    = "wiz-firewall-005"
    Project = "wiz-policy-testing"
  }
}
