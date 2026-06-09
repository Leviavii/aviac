# VirtualMachines-031: Lightsail instance all IPs all ports
# Misconfiguration: public ports allow 0-65535 on all protocols from 0.0.0.0/0

resource "aws_lightsail_instance" "vm031_unrestricted" {
  name              = "vm031-unrestricted"
  availability_zone = "us-east-2a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_3_0"

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: all ports, all protocols, all IPs
resource "aws_lightsail_instance_public_ports" "vm031_all_ports" {
  instance_name = aws_lightsail_instance.vm031_unrestricted.name

  port_info {
    from_port = 0
    to_port   = 65535
    protocol  = "all"
    cidrs     = ["0.0.0.0/0"]
  }
}
