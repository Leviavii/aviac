variable "td009_rootvar_image" {
  type = string
}

resource "aws_ecs_task_definition" "td009_rootvar" {
  family                   = "c2cgap-td009-rootvar"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.td009_rootvar_image
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}
