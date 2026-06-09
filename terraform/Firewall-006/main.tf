variable "vpc_id" {}

resource "aws_security_group" "wiz_firewall_006" {
  name        = "wiz-firewall-006-sg"
  description = "Misconfigured SG for Firewall-006"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name    = "wiz-firewall-006"
    Project = "wiz-policy-testing"
  }
}
