# ELB-002: Classic Load Balancer insecure SSL ciphers
# Misconfiguration: SSL policy uses insecure ciphers (RC4, 3DES, ARIA, etc.)

variable "subnet_public_a_id" {}

resource "tls_private_key" "elb002_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "elb002_cert" {
  private_key_pem = tls_private_key.elb002_key.private_key_pem
  subject {
    common_name = "elb002.wiz-policy-testing.local"
  }
  validity_period_hours = 8760
  allowed_uses          = ["server_auth"]
}

resource "aws_acm_certificate" "elb002_cert" {
  private_key      = tls_private_key.elb002_key.private_key_pem
  certificate_body = tls_self_signed_cert.elb002_cert.cert_pem

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_elb" "elb002_insecure_ssl" {
  name    = "elb002-insecure-ssl"
  subnets = [var.subnet_public_a_id]

  listener {
    instance_port      = 443
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.elb002_cert.arn
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
