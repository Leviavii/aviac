module "base" {
  source     = "./base"
  aws_region = var.aws_region
}


module "APIGateway-001" {
  source = "./APIGateway-001"
}

module "CICDService-005" {
  source = "./CICDService-005"
  codebuild_role_arn       = module.base.codebuild_role_arn
}

module "CICDService-013" {
  source = "./CICDService-013"
  codebuild_role_arn       = module.base.codebuild_role_arn
}

module "CICDService-014" {
  source = "./CICDService-014"
  codebuild_role_arn       = module.base.codebuild_role_arn
}

module "CRS-001" {
  source = "./CRS-001"
}

module "DataWorkflow-012" {
  source = "./DataWorkflow-012"
}

module "DataWorkload-004" {
  source = "./DataWorkload-004"
  vpc_id                   = module.base.vpc_id
  subnet_public_a_id       = module.base.subnet_public_a_id
  subnet_public_b_id       = module.base.subnet_public_b_id
}

module "DatabaseServer-042" {
  source = "./DatabaseServer-042"
}

module "DatabaseServer-099" {
  source = "./DatabaseServer-099"
  vpc_id                   = module.base.vpc_id
  subnet_public_a_id       = module.base.subnet_public_a_id
  subnet_public_b_id       = module.base.subnet_public_b_id
}

module "EBS-007" {
  source = "./EBS-007"
}

module "EC2-004" {
  source = "./EC2-004"
  ami_id                   = module.base.ami_id
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "EC2-011" {
  source = "./EC2-011"
  ami_id                   = module.base.ami_id
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "EC2-028" {
  source = "./EC2-028"
  ami_id                   = module.base.ami_id
}

module "EFS-005" {
  source = "./EFS-005"
}

module "EKS-011" {
  source = "./EKS-011"
  eks_role_arn             = module.base.eks_role_arn
  subnet_public_a_id       = module.base.subnet_public_a_id
  subnet_public_b_id       = module.base.subnet_public_b_id
}

module "ELB-002" {
  source = "./ELB-002"
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "Elasticsearch-005" {
  source = "./Elasticsearch-005"
}

module "Elasticsearch-006" {
  source = "./Elasticsearch-006"
}

module "Firewall-001" {
  source = "./Firewall-001"
  vpc_id                   = module.base.vpc_id
}

module "Firewall-003" {
  source = "./Firewall-003"
  vpc_id                   = module.base.vpc_id
}

module "Firewall-004" {
  source = "./Firewall-004"
  vpc_id                   = module.base.vpc_id
}

module "Firewall-005" {
  source = "./Firewall-005"
  vpc_id                   = module.base.vpc_id
}

module "Firewall-006" {
  source = "./Firewall-006"
  vpc_id                   = module.base.vpc_id
}

module "Firewall-007" {
  source = "./Firewall-007"
  vpc_id                   = module.base.vpc_id
}

module "IAM-052" {
  source = "./IAM-052"
}

module "IAM-077" {
  source = "./IAM-077"
}

module "IAM-081" {
  source = "./IAM-081"
}

module "IAM-147" {
  source = "./IAM-147"
}

module "IAM-176" {
  source = "./IAM-176"
}

module "IAM-185" {
  source = "./IAM-185"
}

module "IAM-236" {
  source = "./IAM-236"
}

module "IDP-001" {
  source = "./IDP-001"
}

module "IDP-002" {
  source = "./IDP-002"
}

module "IDP-007" {
  source = "./IDP-007"
}

module "InstanceGroup-029" {
  source = "./InstanceGroup-029"
}

module "InstanceGroup-033" {
  source = "./InstanceGroup-033"
  ami_id                   = module.base.ami_id
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "InstanceGroup-034" {
  source = "./InstanceGroup-034"
  ami_id                   = module.base.ami_id
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "InstanceGroup-035" {
  source = "./InstanceGroup-035"
  ami_id                   = module.base.ami_id
  subnet_public_a_id       = module.base.subnet_public_a_id
}

module "Lambda-002" {
  source = "./Lambda-002"
  lambda_role_arn          = module.base.lambda_role_arn
}

module "Lambda-003" {
  source = "./Lambda-003"
  lambda_role_arn          = module.base.lambda_role_arn
}

module "MessagingService-030" {
  source = "./MessagingService-030"
  vpc_id                   = module.base.vpc_id
  subnet_public_a_id       = module.base.subnet_public_a_id
  subnet_public_b_id       = module.base.subnet_public_b_id
  subnet_private_a_id      = module.base.subnet_private_a_id
}

module "Neptune-011" {
  source = "./Neptune-011"
}

module "PrivateEndpoint-001" {
  source = "./PrivateEndpoint-001"
}

module "RDS-003" {
  source = "./RDS-003"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "RDS-004" {
  source = "./RDS-004"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "RDS-014" {
  source = "./RDS-014"
}

module "RDS-015" {
  source = "./RDS-015"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "Redshift-001" {
  source = "./Redshift-001"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "Redshift-002" {
  source = "./Redshift-002"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "S3-003" {
  source = "./S3-003"
}

module "S3-004" {
  source = "./S3-004"
}

module "S3-005" {
  source = "./S3-005"
}

module "S3-006" {
  source = "./S3-006"
}

module "S3-007" {
  source = "./S3-007"
}

module "S3-011" {
  source = "./S3-011"
}

module "S3-012" {
  source = "./S3-012"
}

module "S3-016" {
  source = "./S3-016"
}

module "S3-017" {
  source = "./S3-017"
}

module "S3-018" {
  source = "./S3-018"
}

module "S3-019" {
  source = "./S3-019"
}

module "S3-029" {
  source = "./S3-029"
}

module "S3-037" {
  source = "./S3-037"
}

module "S3-038" {
  source = "./S3-038"
}

module "S3-039" {
  source = "./S3-039"
}

module "S3-040" {
  source = "./S3-040"
}

module "S3-046" {
  source = "./S3-046"
}

module "S3-047" {
  source = "./S3-047"
}

module "SQS-011" {
  source = "./SQS-011"
}

module "Serverless-002" {
  source = "./Serverless-002"
  lambda_role_arn          = module.base.lambda_role_arn
}

module "ServiceConfiguration-052" {
  source = "./ServiceConfiguration-052"
}

module "Snapshot-007" {
  source = "./Snapshot-007"
}

module "Snapshot-008" {
  source = "./Snapshot-008"
  db_subnet_group_name     = module.base.db_subnet_group_name
}

module "TaskDefinition-004" {
  source = "./TaskDefinition-004"
}

module "VPC-013" {
  source = "./VPC-013"
  vpc_id                   = module.base.vpc_id
}

module "VPC-014" {
  source = "./VPC-014"
  vpc_id                   = module.base.vpc_id
}

module "VPC-015" {
  source = "./VPC-015"
  vpc_id                   = module.base.vpc_id
}

module "VPC-016" {
  source = "./VPC-016"
  vpc_id                   = module.base.vpc_id
}

module "VPC-017" {
  source = "./VPC-017"
  vpc_id                   = module.base.vpc_id
}

module "VPC-018" {
  source = "./VPC-018"
  vpc_id                   = module.base.vpc_id
}

module "VPC-019" {
  source = "./VPC-019"
  vpc_id                   = module.base.vpc_id
}

module "VPC-020" {
  source = "./VPC-020"
  vpc_id                   = module.base.vpc_id
}

module "VPC-021" {
  source = "./VPC-021"
  vpc_id                   = module.base.vpc_id
}

module "VPC-022" {
  source = "./VPC-022"
  vpc_id                   = module.base.vpc_id
}

module "VPC-023" {
  source = "./VPC-023"
  vpc_id                   = module.base.vpc_id
}

module "VPC-024" {
  source = "./VPC-024"
  vpc_id                   = module.base.vpc_id
}

module "VPC-025" {
  source = "./VPC-025"
  vpc_id                   = module.base.vpc_id
}

module "VPC-026" {
  source = "./VPC-026"
  vpc_id                   = module.base.vpc_id
}

module "VPC-027" {
  source = "./VPC-027"
  vpc_id                   = module.base.vpc_id
}

module "VPC-028" {
  source = "./VPC-028"
  vpc_id                   = module.base.vpc_id
}

module "VPC-029" {
  source = "./VPC-029"
  vpc_id                   = module.base.vpc_id
}

module "VPC-030" {
  source = "./VPC-030"
  vpc_id                   = module.base.vpc_id
}

module "VPC-031" {
  source = "./VPC-031"
  vpc_id                   = module.base.vpc_id
}

module "VPC-032" {
  source = "./VPC-032"
  vpc_id                   = module.base.vpc_id
}

module "VPC-034" {
  source = "./VPC-034"
  vpc_id                   = module.base.vpc_id
}

module "VPC-051" {
  source = "./VPC-051"
  vpc_id                   = module.base.vpc_id
}

module "VPC-052" {
  source = "./VPC-052"
  vpc_id                   = module.base.vpc_id
}

module "VPC-053" {
  source = "./VPC-053"
  vpc_id                   = module.base.vpc_id
}

module "VPC-054" {
  source = "./VPC-054"
  vpc_id                   = module.base.vpc_id
}

module "VPC-055" {
  source = "./VPC-055"
  vpc_id                   = module.base.vpc_id
}

module "VPC-057" {
  source = "./VPC-057"
  vpc_id                   = module.base.vpc_id
}

module "VPC-058" {
  source = "./VPC-058"
  vpc_id                   = module.base.vpc_id
}

module "VPC-060" {
  source = "./VPC-060"
  vpc_id                   = module.base.vpc_id
}

module "VPC-061" {
  source = "./VPC-061"
  vpc_id                   = module.base.vpc_id
}

module "VPC-064" {
  source = "./VPC-064"
  vpc_id                   = module.base.vpc_id
}

module "VPC-065" {
  source = "./VPC-065"
  vpc_id                   = module.base.vpc_id
}

module "VPC-066" {
  source = "./VPC-066"
  vpc_id                   = module.base.vpc_id
}

module "VPC-067" {
  source = "./VPC-067"
  vpc_id                   = module.base.vpc_id
}

module "VPC-068" {
  source = "./VPC-068"
  vpc_id                   = module.base.vpc_id
}

module "VPC-069" {
  source = "./VPC-069"
  vpc_id                   = module.base.vpc_id
}

module "VPC-070" {
  source = "./VPC-070"
  vpc_id                   = module.base.vpc_id
}

module "VPC-071" {
  source = "./VPC-071"
  vpc_id                   = module.base.vpc_id
}

module "VPC-075" {
  source = "./VPC-075"
  vpc_id                   = module.base.vpc_id
}

module "VPC-085" {
  source = "./VPC-085"
  vpc_id                   = module.base.vpc_id
}

module "VPC-093" {
  source = "./VPC-093"
  vpc_id                   = module.base.vpc_id
}

module "VPC-100" {
  source = "./VPC-100"
  vpc_id                   = module.base.vpc_id
}

module "VPC-101" {
  source = "./VPC-101"
  vpc_id                   = module.base.vpc_id
}

module "VPC-104" {
  source = "./VPC-104"
}

module "VPC-106" {
  source = "./VPC-106"
  vpc_id                   = module.base.vpc_id
}

module "VPC-107" {
  source = "./VPC-107"
}

module "VPC-108" {
  source = "./VPC-108"
  vpc_id                   = module.base.vpc_id
}

module "VirtualMachines-031" {
  source = "./VirtualMachines-031"
}

module "VirtualMachines-032" {
  source = "./VirtualMachines-032"
}

module "VirtualMachines-033" {
  source = "./VirtualMachines-033"
}

module "VirtualMachines-034" {
  source = "./VirtualMachines-034"
}

module "WAF-008" {
  source = "./WAF-008"
}
