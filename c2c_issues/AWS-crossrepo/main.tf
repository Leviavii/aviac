# Cross-repo code-to-cloud source-tracing test.
#
# The misconfigured RESOURCES live in modules in the aviactwo repo. This caller
# (aviac) only wires inputs and calls those modules via a git:: source. After
# deploy, each cloud finding should source-trace back to the aviactwo module
# file — not to this caller — which is the point of the test.
#
# Separate statefile (AWS-crossrepo) so it does not touch the main AWS batch.

data "aws_subnet" "public_a" {
  id = "subnet-0bf79cdce6f1ba783"
}

data "aws_subnet" "public_b" {
  id = "subnet-032ce6b451acafe0e"
}

# DB subnet group is plain wiring (not a misconfig), so it lives in the caller.
resource "aws_db_subnet_group" "crossrepo" {
  name       = "wiz-crossrepo-db-subnet"
  subnet_ids = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  tags = { Project = "wiz-c2c-crossrepo-test" }
}

module "insecure_storage" {
  source            = "git::https://github.com/Leviavii/aviactwo.git//modules/insecure-storage?ref=main"
  name_prefix       = "wiz-crossrepo-306026247677"
  availability_zone = data.aws_subnet.public_a.availability_zone
}

module "insecure_app" {
  source      = "git::https://github.com/Leviavii/aviactwo.git//modules/insecure-app?ref=main"
  name_prefix = "wiz-crossrepo"
}

module "insecure_network" {
  source               = "git::https://github.com/Leviavii/aviactwo.git//modules/insecure-network?ref=main"
  name_prefix          = "wiz-crossrepo"
  db_subnet_group_name = aws_db_subnet_group.crossrepo.name
}
