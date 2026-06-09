# ELB-002: Classic Load Balancer insecure SSL ciphers
# Misconfiguration: SSL policy uses insecure ciphers (RC4, 3DES, ARIA, etc.)

variable "subnet_public_a_id" {}

resource "aws_elb" "elb002_insecure_ssl" {
  name    = "elb002-insecure-ssl"
  subnets = [var.subnet_public_a_id]

  listener {
    instance_port      = 443
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:acm:us-east-2:000000000000:certificate/placeholder"
  }

  tags = {
    Name    = "elb002-insecure-ssl"
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: SSL policy enables insecure ciphers
resource "aws_load_balancer_policy" "elb002_insecure_ssl_policy" {
  load_balancer_name = aws_elb.elb002_insecure_ssl.name
  policy_name        = "elb002-insecure-ssl-policy"
  policy_type_name   = "SSLNegotiationPolicyType"

  policy_attribute {
    name  = "Protocol-TLSv1.2"
    value = "true"
  }

  # Insecure cipher
  policy_attribute {
    name  = "TLS_RSA_ARCFOUR_128_SHA1"
    value = "true"
  }
}

resource "aws_load_balancer_listener_policy" "elb002_listener_policy" {
  load_balancer_name = aws_elb.elb002_insecure_ssl.name
  load_balancer_port = 443

  policy_names = [
    aws_load_balancer_policy.elb002_insecure_ssl_policy.policy_name,
  ]
}
