# VirtualMachines-032: Lightsail instance all protocols all ports
# Misconfiguration: public ports allow all protocols 0-65535 from 0.0.0.0/0

resource "aws_lightsail_instance" "vm032_all_protocols" {
  name              = "vm032-all-protocols"
  availability_zone = "us-east-2a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_3_0"

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: all protocols, all ports, all IPs
resource "aws_lightsail_instance_public_ports" "vm032_all_protocols_ports" {
  instance_name = aws_lightsail_instance.vm032_all_protocols.name

  port_info {
    protocol  = "all"
    from_port = 0
    to_port   = 65535
    cidrs     = ["0.0.0.0/0"]
  }
}
