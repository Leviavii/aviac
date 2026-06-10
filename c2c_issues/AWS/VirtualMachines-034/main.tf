# VirtualMachines-034: Lightsail instance RDP open
# Misconfiguration: RDP port 3389 open to 0.0.0.0/0

resource "aws_lightsail_instance" "vm034_rdp_open" {
  name              = "vm034-rdp-open"
  availability_zone = "us-east-2a"
  blueprint_id      = "windows_server_2022"
  bundle_id         = "micro_win_3_0"

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: RDP port open to all IPs
resource "aws_lightsail_instance_public_ports" "vm034_rdp_ports" {
  instance_name = aws_lightsail_instance.vm034_rdp_open.name

  port_info {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    cidrs     = ["0.0.0.0/0"]
  }
}
