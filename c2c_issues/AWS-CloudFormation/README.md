# AWS CloudFormation — C2C test corpus

50 CloudFormation templates, one per high-severity AWS CSPM rule. Each reproduces the
**exact** misconfiguration its rule's rego flags (no bypasses), so it triggers both the
IaC scan (CF template in this repo) and the cloud finding (deployed resource) — the two
sides Wiz correlates for Code-to-Cloud.

All 50 pass `cfn-lint` with 0 errors. Source of each misconfig: the matching
`cspm/builtinRules/<RULE>/cloud_formation` fixture in builtins-updater-catalog.

## Coverage (50 rules)
- **Security groups (22):** Firewall-004,005,006,007; VPC-013…030
- **S3 (12):** S3-004,011,012,016,017,018,019,029,036,037,038,039
- **IAM (2):** IAM-147, IAM-236
- **Other (14):** EFS-005, EC2-004, EC2-005, EC2-011, APIGateway-001, CloudTrail-008,
  IDP-001, Lambda-003, InstanceGroup-021 (ECS), CRS-001 (ECR), VirtualMachines-031,
  VirtualMachines-033 (Lightsail), CICDService-005 (CodeBuild), InstanceGroup-034 (ASG)

## Deploy
Each template is its own stack: `aws cloudformation deploy --template-file <RULE>.yaml --stack-name c2c-<rule> --capabilities CAPABILITY_NAMED_IAM`

Templates that need parameters (pass the dev-play account's default VPC/subnet):
- **VpcId** (22 security groups): `--parameter-overrides VpcId=vpc-xxxx`
- **SubnetId** (EC2-004, EC2-011): `--parameter-overrides SubnetId=subnet-xxxx`
- **VpcId + SubnetIds** (InstanceGroup-021 / ECS)
- **SubnetIds** (InstanceGroup-034 / ASG)

The other ~24 are fully self-contained.

## Known deploy caveats
- **Lambda-003** — references a placeholder layer ARN (creates a `LayerVersionPermission` only);
  triggers the IaC scan but will NOT deploy as-is. Needs a real layer first, or treat as scan-only.
- **EC2-004** — modeled as an `AWS::EC2::LaunchTemplate` (not a running instance); triggers the
  IaC scan but produces no EC2 *instance* cloud resource.
- **EC2-005** — EC2-Classic-style security group reference; may fail in VPC-only regions.
- **S3 BPA rules (S3-012, 037, 038, 039)** — faithfully reproduce the bucket-level Block-Public-Access
  misconfig, but an **account-level BPA** may override it, suppressing the cloud finding.
- **S3-004 / S3-011** — re-enable ACLs via `OwnershipControls: ObjectWriter` + bucket-level BPA off so
  the public ACL deploys (account-level BPA may still override).

Misconfig fidelity (does it trigger the rego) is guaranteed; the caveats above are about whether
the *deployed* side also produces a cloud finding.
