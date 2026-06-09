# EKS-011: EKS Cluster endpoint open to all IPs
# Misconfiguration: public_access_cidrs = ["0.0.0.0/0"] or endpoint_public_access = true without restrictions

variable "eks_role_arn" {}
variable "subnet_public_a_id" {}
variable "subnet_public_b_id" {}

resource "aws_eks_cluster" "eks011_public_endpoint" {
  name     = "eks011-public-endpoint"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = [var.subnet_public_a_id, var.subnet_public_b_id]
    # MISCONFIGURATION: public access CIDRs include 0.0.0.0/0 (all IPs)
    endpoint_public_access = true
    public_access_cidrs    = ["0.0.0.0/0"]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
