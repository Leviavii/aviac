# Elasticsearch-005: OpenSearch domain allows anonymous access
# Misconfiguration: anonymous_auth_enabled = true

resource "aws_opensearch_domain" "es005_anonymous_access" {
  domain_name    = "es005-anon-access"
  engine_version = "OpenSearch_2.5"

  cluster_config {
    instance_type = "t3.small.search"
  }

  advanced_security_options {
    enabled                        = true
    # MISCONFIGURATION: anonymous auth enabled
    anonymous_auth_enabled         = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = "admin"
      master_user_password = "Admin1234!"
    }
  }

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  node_to_node_encryption {
    enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
