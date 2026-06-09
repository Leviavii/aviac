# EC2-011: Instance with public IP
# Misconfiguration: associate_public_ip_address = true

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_instance" "ec2011_public_ip" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_public_a_id
  # MISCONFIGURATION: instance has public IP
  associate_public_ip_address = true

  tags = {
    Name    = "ec2011-public-ip"
    Project = "wiz-policy-testing"
  }
}
