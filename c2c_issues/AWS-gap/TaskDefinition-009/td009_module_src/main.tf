variable "image" {
  type = string
}

resource "aws_ecs_task_definition" "td009_module_task" {
  family                   = "c2cgap-td009-module-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.image
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}
