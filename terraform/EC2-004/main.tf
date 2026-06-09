# EC2-004: Instance not using IMDSv2
# Misconfiguration: http_tokens not set to "required" (IMDSv1 still enabled)

variable "ami_id" {}
variable "subnet_public_a_id" {}

resource "aws_instance" "ec2004_no_imdsv2" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_public_a_id

  # MISCONFIGURATION: http_tokens not required, allowing IMDSv1
  metadata_options {
    http_endpoint = "enabled"
  }

  tags = {
    Name    = "ec2004-no-imdsv2"
    Project = "wiz-policy-testing"
  }
}
