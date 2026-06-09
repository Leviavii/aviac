# TaskDefinition-004: ECS Task Definition insecure networking
# Misconfiguration: network_mode = "host"

resource "aws_ecs_task_definition" "taskdef004_host_network" {
  family       = "taskdef004-host-network"
  # MISCONFIGURATION: host network mode exposes all host ports
  network_mode = "host"

  container_definitions = jsonencode([
    {
      name   = "app"
      image  = "nginx:latest"
      memory = 512
      cpu    = 256
    }
  ])

  tags = {
    Project = "wiz-policy-testing"
  }
}
