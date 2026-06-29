# Cross-repo code-to-cloud source-tracing test (correct architecture).
#
# The RESOURCES are declared HERE in aviac. Their misconfigured fields pull their
# values from the aviactwo `bad-values` module (the misconfiguration's source).
# The test: does the analyzer trace each misconfig back to aviactwo, and does the
# green agent put the fix in the module (value origin) vs the resource (here)?

data "aws_caller_identity" "current" {}

data "aws_subnet" "public_a" {
  id = "subnet-0bf79cdce6f1ba783"
}

data "aws_subnet" "public_b" {
  id = "subnet-032ce6b451acafe0e"
}

resource "aws_db_subnet_group" "crossrepo" {
  name       = "wiz-xrepo-db-subnet"
  subnet_ids = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]
  tags       = { Project = "wiz-c2c-crossrepo-test" }
}

# The misconfiguration VALUES come from aviactwo.
module "bad" {
  source        = "git::https://github.com/Leviavii/aviactwo.git//modules/bad-values?ref=main"
  account_id    = data.aws_caller_identity.current.account_id
  s3_bucket_arn = aws_s3_bucket.s3_013.arn
  eventbus_arn  = aws_cloudwatch_event_bus.ms_033.arn
}

# S3-013 — bucket policy (missing deny-HTTP) sourced from the module
resource "aws_s3_bucket" "s3_013" {
  bucket = "wiz-xrepo-306026247677-s3-013"
  tags   = { Project = "wiz-c2c-crossrepo-test" }
}

resource "aws_s3_bucket_policy" "s3_013" {
  bucket = aws_s3_bucket.s3_013.id
  policy = module.bad.s3_bucket_policy
}

# DynamoDB-003 — PITR flag sourced from the module
resource "aws_dynamodb_table" "ddb_003" {
  name         = "wiz-xrepo-ddb-003"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = module.bad.pitr_enabled
  }

  tags = { Project = "wiz-c2c-crossrepo-test" }
}

# EBS-003 / Snapshot-003 — encryption flag sourced from the module
resource "aws_ebs_volume" "ebs_003" {
  availability_zone = data.aws_subnet.public_a.availability_zone
  size              = 1
  encrypted         = module.bad.ebs_encrypted
  tags              = { Project = "wiz-c2c-crossrepo-test" }
}

resource "aws_ebs_snapshot" "snapshot_003" {
  volume_id = aws_ebs_volume.ebs_003.id
  tags      = { Project = "wiz-c2c-crossrepo-test" }
}

# MessagingService-033 — bus policy (Principal '*') sourced from the module
resource "aws_cloudwatch_event_bus" "ms_033" {
  name = "wiz-xrepo-bus-033"
  tags = { Project = "wiz-c2c-crossrepo-test" }
}

resource "aws_cloudwatch_event_bus_policy" "ms_033" {
  event_bus_name = aws_cloudwatch_event_bus.ms_033.name
  policy         = module.bad.eventbus_policy
}

# Gateway-001 — auto-accept value sourced from the module
resource "aws_ec2_transit_gateway" "gw_001" {
  description                    = "wiz-xrepo tgw - auto-accept value from aviactwo module"
  auto_accept_shared_attachments = module.bad.tgw_auto_accept

  tags = {
    Name    = "wiz-xrepo-tgw-001"
    Project = "wiz-c2c-crossrepo-test"
  }
}

# RDS-024 — multi_az and storage_encrypted sourced from the module
resource "aws_db_instance" "rds_024" {
  identifier           = "wiz-xrepo-rds-024"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "wizadmin"
  password             = "Wiz-Crossrepo-Test-123!"
  db_subnet_group_name = aws_db_subnet_group.crossrepo.name
  multi_az             = module.bad.multi_az
  storage_encrypted    = module.bad.storage_encrypted
  publicly_accessible  = false
  skip_final_snapshot  = true
  tags                 = { Project = "wiz-c2c-crossrepo-test" }
}

# RDS-027 — deletion_protection sourced from the module
resource "aws_rds_cluster" "rds_027" {
  cluster_identifier   = "wiz-xrepo-rds-027"
  engine               = "aurora-mysql"
  master_username      = "wizadmin"
  master_password      = "Wiz-Crossrepo-Test-123!"
  db_subnet_group_name = aws_db_subnet_group.crossrepo.name
  deletion_protection  = module.bad.deletion_protection
  skip_final_snapshot  = true
  tags                 = { Project = "wiz-c2c-crossrepo-test" }
}

# APIGateway-011 — stage logging level sourced from the module ("OFF")
resource "aws_api_gateway_rest_api" "api_011" {
  name = "wiz-xrepo-api-011"
  tags = { Project = "wiz-c2c-crossrepo-test" }
}

resource "aws_api_gateway_resource" "api_011" {
  rest_api_id = aws_api_gateway_rest_api.api_011.id
  parent_id   = aws_api_gateway_rest_api.api_011.root_resource_id
  path_part   = "test"
}

resource "aws_api_gateway_method" "api_011" {
  rest_api_id   = aws_api_gateway_rest_api.api_011.id
  resource_id   = aws_api_gateway_resource.api_011.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_011" {
  rest_api_id = aws_api_gateway_rest_api.api_011.id
  resource_id = aws_api_gateway_resource.api_011.id
  http_method = aws_api_gateway_method.api_011.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_deployment" "api_011" {
  rest_api_id = aws_api_gateway_rest_api.api_011.id
  depends_on  = [aws_api_gateway_integration.api_011]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_011" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api_011.id
  deployment_id = aws_api_gateway_deployment.api_011.id
  tags          = { Project = "wiz-c2c-crossrepo-test" }
}

resource "aws_api_gateway_method_settings" "api_011" {
  rest_api_id = aws_api_gateway_rest_api.api_011.id
  stage_name  = aws_api_gateway_stage.api_011.stage_name
  method_path = "*/*"

  settings {
    logging_level   = module.bad.api_logging_level
    metrics_enabled = false
  }
}
