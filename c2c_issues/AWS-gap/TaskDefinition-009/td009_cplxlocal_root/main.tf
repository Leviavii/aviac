locals {
  td009_local_containers = [
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
    }
  ]
  td009_objlocal_container = {
    name      = "app"
    image     = "nginx:latest"
    essential = true
  }
}

resource "aws_ecs_task_definition" "td009_local" {
  family                   = "c2cgap-td009-local"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode(local.td009_local_containers)

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_objlocal" {
  family                   = "c2cgap-td009-objlocal"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([local.td009_objlocal_container])

  tags = {
    Rule = "TaskDefinition-009"
  }
}
