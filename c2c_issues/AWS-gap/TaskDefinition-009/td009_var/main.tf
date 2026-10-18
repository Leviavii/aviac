variable "td009_var_container_definitions" {
  type    = string
  default = "[{\"name\":\"app\",\"image\":\"nginx:latest\",\"essential\":true}]"
}

resource "aws_ecs_task_definition" "td009_var" {
  family                   = "c2cgap-td009-var"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = var.td009_var_container_definitions

  tags = {
    Rule = "TaskDefinition-009"
  }
}
