variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

locals {
  td005_locals_containers = [
    {
      name      = "app"
      image     = "public.ecr.aws/docker/library/busybox:latest"
      cpu       = 256
      memory    = 512
      essential = true
    }
  ]
}

resource "aws_ecs_task_definition" "td005_explicit_false" {
  family = "c2cgap-taskdefinition005-explicit-false"
  container_definitions = jsonencode([
    {
      name                   = "app"
      image                  = "public.ecr.aws/docker/library/busybox:latest"
      cpu                    = 256
      memory                 = 512
      essential              = true
      readonlyRootFilesystem = false
    }
  ])
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_omitted" {
  family = "c2cgap-taskdefinition005-omitted"
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

resource "aws_ecs_task_definition" "td005_mixed" {
  family = "c2cgap-taskdefinition005-mixed"
  container_definitions = jsonencode([
    {
      name                   = "app"
      image                  = "public.ecr.aws/docker/library/busybox:latest"
      cpu                    = 256
      memory                 = 512
      essential              = true
      readonlyRootFilesystem = true
    },
    {
      name      = "sidecar"
      image     = "public.ecr.aws/docker/library/busybox:latest"
      cpu       = 128
      memory    = 256
      essential = false
    }
  ])
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_locals" {
  family                = "c2cgap-taskdefinition005-locals"
  container_definitions = jsonencode(local.td005_locals_containers)
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_var_nodefault" {
  family = "c2cgap-taskdefinition005-var-nodefault"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/app:latest"
      cpu       = 256
      memory    = 512
      essential = true
    }
  ])
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_templatefile" {
  family                = "c2cgap-taskdefinition005-templatefile"
  container_definitions = templatefile("${path.module}/td005_templatefile_containers.json.tpl", { image = "public.ecr.aws/docker/library/busybox:latest" })
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_file" {
  family                = "c2cgap-taskdefinition005-file"
  container_definitions = file("${path.module}/td005_file_containers.json")
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "awscc_ecs_task_definition" "td005_awscc_false" {
  family                   = "c2cgap-taskdefinition005-awscc-false"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = [
    {
      name                     = "app"
      image                    = "busybox:latest"
      essential                = true
      readonly_root_filesystem = false
    }
  ]
  tags = [
    {
      key   = "Rule"
      value = "TaskDefinition-005"
    }
  ]
}

resource "awscc_ecs_task_definition" "td005_awscc_omitted" {
  family                   = "c2cgap-taskdefinition005-awscc-omitted"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = [
    {
      name      = "app"
      image     = "busybox:latest"
      essential = true
    }
  ]
  tags = [
    {
      key   = "Rule"
      value = "TaskDefinition-005"
    }
  ]
}

resource "aws_ecs_cluster" "td005_heredoc_cluster" {
  name = "c2cgap-taskdefinition005-heredoc"
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_task_definition" "td005_heredoc" {
  family                = "c2cgap-taskdefinition005-heredoc"
  container_definitions = <<DEFINITION
[
  {
    "name": "c2cgap-taskdefinition005-heredoc-web",
    "image": "public.ecr.aws/docker/library/busybox:latest",
    "cpu": 256,
    "memory": 512,
    "essential": true
  }
]
DEFINITION
  tags = {
    Rule = "TaskDefinition-005"
  }
}

resource "aws_ecs_service" "td005_heredoc_svc" {
  name            = "c2cgap-taskdefinition005-heredoc-web"
  cluster         = aws_ecs_cluster.td005_heredoc_cluster.arn
  task_definition = aws_ecs_task_definition.td005_heredoc.arn
  desired_count   = 0
  tags = {
    Rule = "TaskDefinition-005"
  }
}
