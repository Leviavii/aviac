# Elasticsearch-006: OpenSearch domain publicly accessible
# Misconfiguration: no VPC endpoint configured (domain is publicly accessible)

resource "aws_opensearch_domain" "es006_public_domain" {
  domain_name    = "es006-public"
  engine_version = "OpenSearch_2.5"

  cluster_config {
    instance_type = "t3.small.search"
  }

  # MISCONFIGURATION: no vpc_options block, making domain publicly accessible

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
