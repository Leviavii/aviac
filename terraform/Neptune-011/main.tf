# Neptune-011: Neptune Graph public connectivity
# Misconfiguration: public_connectivity = true

resource "aws_neptunegraph_graph" "neptune011_public_graph" {
  graph_name          = "neptune011-public-graph"
  provisioned_memory  = 128
  # MISCONFIGURATION: public connectivity enabled
  public_connectivity = true

  tags = {
    Project = "wiz-policy-testing"
  }
}
