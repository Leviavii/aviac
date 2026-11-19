terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "avitch-awesome-tf-bucket"
    key    = "c2c_issues/AWS-phase2-acm/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Project = "wiz-c2c-phase2-acm"
    }
  }
}

# --- Certificate-004: wildcard domains (requested certs stay PENDING_VALIDATION, DVOs still exist) ---

resource "aws_acm_certificate" "wildcard_main" {
  domain_name       = "*.c2cfam.example.com"
  validation_method = "DNS"
  tags              = { Rule = "Certificate-004", Case = "wildcard-domain-name" }
  lifecycle { create_before_destroy = true }
}

resource "aws_acm_certificate" "wildcard_san" {
  domain_name               = "app.c2cfam.example.com"
  subject_alternative_names = ["*.san.c2cfam.example.com"]
  validation_method         = "DNS"
  tags                      = { Rule = "Certificate-004", Case = "wildcard-in-san-only" }
  lifecycle { create_before_destroy = true }
}

resource "aws_acm_certificate" "clean_default_key" {
  domain_name       = "www.c2cfam.example.com"
  validation_method = "DNS"
  tags              = { Rule = "Certificate-004 Certificate-012", Case = "no-wildcard-default-rsa2048" }
  lifecycle { create_before_destroy = true }
}

resource "aws_acm_certificate" "clean_ec" {
  domain_name       = "api.c2cfam.example.com"
  key_algorithm     = "EC_prime256v1"
  validation_method = "DNS"
  tags              = { Rule = "Certificate-012", Case = "ec-prime256v1" }
  lifecycle { create_before_destroy = true }
}

# --- Certificate-012: imported self-signed certs (KeyAlgorithm set, no DVOs) ---

resource "tls_private_key" "rsa4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "rsa4096" {
  private_key_pem       = tls_private_key.rsa4096.private_key_pem
  validity_period_hours = 8760
  allowed_uses          = ["server_auth"]
  subject { common_name = "import-rsa4096.c2cfam.example.com" }
}

resource "aws_acm_certificate" "import_rsa4096" {
  private_key      = tls_private_key.rsa4096.private_key_pem
  certificate_body = tls_self_signed_cert.rsa4096.cert_pem
  tags             = { Rule = "Certificate-012", Case = "imported-rsa4096" }
}

resource "tls_private_key" "p384" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "p384" {
  private_key_pem       = tls_private_key.p384.private_key_pem
  validity_period_hours = 8760
  allowed_uses          = ["server_auth"]
  subject { common_name = "import-p384.c2cfam.example.com" }
}

resource "aws_acm_certificate" "import_p384" {
  private_key      = tls_private_key.p384.private_key_pem
  certificate_body = tls_self_signed_cert.p384.cert_pem
  tags             = { Rule = "Certificate-012", Case = "imported-ec-secp384r1" }
}

# Imported wildcard cert: no DomainValidationOptions on imports, so Certificate-004 cloud should NOT fail it
resource "tls_private_key" "wild" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "wild" {
  private_key_pem       = tls_private_key.wild.private_key_pem
  validity_period_hours = 8760
  allowed_uses          = ["server_auth"]
  subject { common_name = "*.imported.c2cfam.example.com" }
}

resource "aws_acm_certificate" "import_wildcard" {
  private_key      = tls_private_key.wild.private_key_pem
  certificate_body = tls_self_signed_cert.wild.cert_pem
  tags             = { Rule = "Certificate-004", Case = "imported-wildcard-no-dvo" }
}
