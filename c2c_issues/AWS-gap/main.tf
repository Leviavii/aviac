module "base" {
  source = "./base"
}

module "apigateway_005" {
  source = "./APIGateway-005"
}

module "apigateway_006" {
  source = "./APIGateway-006"
}

module "apigateway_008" {
  source = "./APIGateway-008"
}

module "apigateway_009" {
  source          = "./APIGateway-009"
  lambda_role_arn = module.base.lambda_role_arn
}

module "apigateway_010" {
  source          = "./APIGateway-010"
  lambda_role_arn = module.base.lambda_role_arn
}

module "apigateway_013" {
  source = "./APIGateway-013"
}

module "apigateway_015" {
  source = "./APIGateway-015"
}

module "crs_018" {
  source = "./CRS-018"
}

module "cloudwatch_035" {
  source = "./CloudWatch-035"
}

module "dynamodb_003" {
  source = "./DynamoDB-003"
}

module "iam_001" {
  source = "./IAM-001"
}

module "iam_057" {
  source = "./IAM-057"
}

module "iam_146" {
  source     = "./IAM-146"
  account_id = module.base.account_id
}

module "iam_158" {
  source     = "./IAM-158"
  account_id = module.base.account_id
  region     = module.base.region
}

module "iam_197" {
  source = "./IAM-197"
}

module "iam_198" {
  source = "./IAM-198"
}

module "iam_203" {
  source = "./IAM-203"
}

module "iam_213" {
  source = "./IAM-213"
}

module "kms_013" {
  source     = "./KMS-013"
  account_id = module.base.account_id
}

module "s3_001" {
  source     = "./S3-001"
  account_id = module.base.account_id
}

module "s3_002" {
  source     = "./S3-002"
  account_id = module.base.account_id
}

module "s3_008" {
  source     = "./S3-008"
  account_id = module.base.account_id
}

module "s3_010" {
  source     = "./S3-010"
  account_id = module.base.account_id
}

module "s3_013" {
  source     = "./S3-013"
  account_id = module.base.account_id
}

module "s3_023" {
  source     = "./S3-023"
  account_id = module.base.account_id
}

module "s3_041" {
  source     = "./S3-041"
  account_id = module.base.account_id
}

module "s3_042" {
  source     = "./S3-042"
  account_id = module.base.account_id
}

module "s3_044" {
  source     = "./S3-044"
  account_id = module.base.account_id
}

module "s3_045" {
  source     = "./S3-045"
  account_id = module.base.account_id
}

module "s3_052" {
  source     = "./S3-052"
  account_id = module.base.account_id
}

module "sns_009" {
  source     = "./SNS-009"
  account_id = module.base.account_id
  region     = module.base.region
}

module "sns_012" {
  source     = "./SNS-012"
  account_id = module.base.account_id
}

module "sqs_001" {
  source     = "./SQS-001"
  account_id = module.base.account_id
}

module "sqs_002" {
  source = "./SQS-002"
}

module "sqs_004" {
  source = "./SQS-004"
}

module "sqs_010" {
  source     = "./SQS-010"
  account_id = module.base.account_id
  region     = module.base.region
}

module "secret_002" {
  source          = "./Secret-002"
  account_id      = module.base.account_id
  lambda_role_arn = module.base.lambda_role_arn
}

module "secret_003" {
  source     = "./Secret-003"
  account_id = module.base.account_id
  region     = module.base.region
}

module "serverless_009" {
  source          = "./Serverless-009"
  lambda_role_arn = module.base.lambda_role_arn
}

module "serverless_010" {
  source          = "./Serverless-010"
  account_id      = module.base.account_id
  lambda_role_arn = module.base.lambda_role_arn
  region          = module.base.region
}

module "serverless_012" {
  source              = "./Serverless-012"
  lambda_role_arn     = module.base.lambda_role_arn
  subnet_private_a_id = module.base.subnet_private_a_id
  vpc_id              = module.base.vpc_id
}

module "serviceconfiguration_013" {
  source             = "./ServiceConfiguration-013"
  subnet_public_a_id = module.base.subnet_public_a_id
  subnet_public_b_id = module.base.subnet_public_b_id
}

module "taskdefinition_005" {
  source     = "./TaskDefinition-005"
  account_id = module.base.account_id
  region     = module.base.region
}

module "taskdefinition_007" {
  source     = "./TaskDefinition-007"
  account_id = module.base.account_id
  region     = module.base.region
  vpc_id     = module.base.vpc_id
}

module "taskdefinition_009" {
  source            = "./TaskDefinition-009"
  ecs_task_role_arn = module.base.ecs_task_role_arn
  region            = module.base.region
}

module "vpc_056" {
  source = "./VPC-056"
  vpc_id = module.base.vpc_id
}

module "vpc_062" {
  source = "./VPC-062"
  vpc_id = module.base.vpc_id
}

module "vpc_076" {
  source = "./VPC-076"
  vpc_id = module.base.vpc_id
}

module "vpc_082" {
  source = "./VPC-082"
  vpc_id = module.base.vpc_id
}

module "vpc_086" {
  source = "./VPC-086"
  vpc_id = module.base.vpc_id
}

module "vpc_087" {
  source = "./VPC-087"
  vpc_id = module.base.vpc_id
}

module "vpc_088" {
  source = "./VPC-088"
  vpc_id = module.base.vpc_id
}
