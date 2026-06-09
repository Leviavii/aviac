# VirtualMachines-033: Lightsail instance SSH open
# Misconfiguration: SSH port 22 open to 0.0.0.0/0

resource "aws_lightsail_instance" "vm033_ssh_open" {
  name              = "vm033-ssh-open"
  availability_zone = "us-east-2a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_3_0"

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: SSH port open to all IPs
resource "aws_lightsail_instance_public_ports" "vm033_ssh_ports" {
  instance_name = aws_lightsail_instance.vm033_ssh_open.name

  port_info {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidrs     = ["0.0.0.0/0"]
  }
}
