# MessagingService-030: MSK Cluster publicly accessible
# Misconfiguration: public_access type = "SERVICE_PROVIDED_EIPS"

variable "vpc_id" {}
variable "subnet_public_a_id" {}
variable "subnet_public_b_id" {}
variable "subnet_private_a_id" {}

resource "aws_security_group" "msk030_sg" {
  name        = "msk030-sg"
  description = "MSK security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_msk_cluster" "msk030_public_cluster" {
  cluster_name           = "msk030-public-cluster"
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 3

  broker_node_group_info {
    connectivity_info {
      # MISCONFIGURATION: public access enabled via EIPs
      public_access {
        type = "SERVICE_PROVIDED_EIPS"
      }
    }
    instance_type  = "kafka.t3.small"
    client_subnets = [
      var.subnet_public_a_id,
      var.subnet_public_b_id,
      var.subnet_private_a_id,
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 100
      }
    }
    security_groups = [aws_security_group.msk030_sg.id]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
