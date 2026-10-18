resource "aws_ecs_task_definition" "td005_multifile" {
  family = "c2cgap-taskdefinition005-multifile"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "public.ecr.aws/docker/library/busybox:latest"
      cpu       = 256
      memory    = 512
      essential = true
    }
  ])
  tags = {
    Rule = "TaskDefinition-005"
  }
}

output "td005_multifile_task_definition_arn" {
  value = aws_ecs_task_definition.td005_multifile.arn
}
