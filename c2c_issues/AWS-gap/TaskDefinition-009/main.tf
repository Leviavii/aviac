resource "aws_ecs_task_definition" "td009_explicit_root" {
  family                   = "c2cgap-td009-explicit-root"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      user      = "root"
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_default_user" {
  family                   = "c2cgap-td009-default-user"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_sidecar" {
  family                   = "c2cgap-td009-sidecar"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      user      = "1000"
    },
    {
      name      = "log-router"
      image     = "public.ecr.aws/aws-observability/aws-for-fluent-bit:stable"
      essential = false
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_heredoc" {
  family                   = "c2cgap-td009-heredoc"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = <<DEFS
[
  {
    "name": "app",
    "image": "nginx:latest",
    "essential": true
  }
]
DEFS

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_file" {
  family                   = "c2cgap-td009-file"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = file("${path.module}/td009_file_containers.json")

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_templatefile" {
  family                   = "c2cgap-td009-templatefile"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_role_arn
  container_definitions = templatefile("${path.module}/td009_templatefile_containers.json.tpl", {
    image  = "nginx:latest"
    region = var.region
  })

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecr_repository" "td009_refs_repo" {
  name         = "c2cgap-td009-refs"
  force_delete = true

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_cloudwatch_log_group" "td009_refs_logs" {
  name              = "c2cgap-td009-refs"
  retention_in_days = 1

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_refs" {
  family                   = "c2cgap-td009-refs"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_role_arn
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.td009_refs_repo.repository_url}:latest"
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.td009_refs_logs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

locals {
  td009_jsonlocal_defs = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
    }
  ])
  td009_imglocal_image = "nginx:latest"
}

resource "aws_ecs_task_definition" "td009_jsonlocal" {
  family                   = "c2cgap-td009-jsonlocal"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = local.td009_jsonlocal_defs

  tags = {
    Rule = "TaskDefinition-009"
  }
}

module "td009_var" {
  source = "./td009_var"
}

resource "awscc_ecs_task_definition" "td009_awscc_default" {
  family                   = "c2cgap-td009-awscc-default"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = [
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
    }
  ]

  tags = [
    {
      key   = "Rule"
      value = "TaskDefinition-009"
    }
  ]
}

resource "awscc_ecs_task_definition" "td009_awscc_root" {
  family                   = "c2cgap-td009-awscc-root"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = [
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      user      = "root"
    }
  ]

  tags = [
    {
      key   = "Rule"
      value = "TaskDefinition-009"
    }
  ]
}

resource "aws_ecs_task_definition" "td009_imglocal" {
  family                   = "c2cgap-td009-imglocal"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = local.td009_imglocal_image
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

module "td009_module" {
  source = "./td009_module_src"
  image  = "nginx:latest"
}

module "td009_rootvar" {
  source              = "./td009_rootvar"
  td009_rootvar_image = "nginx:latest"
}

data "aws_caller_identity" "td009_data_caller" {}

data "aws_region" "td009_data_region" {}

resource "aws_ecs_task_definition" "td009_data" {
  family                   = "c2cgap-td009-data"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_role_arn
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${data.aws_caller_identity.td009_data_caller.account_id}.dkr.ecr.${data.aws_region.td009_data_region.region}.amazonaws.com/app:latest"
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_forexpr" {
  family                   = "c2cgap-td009-forexpr"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      environment = [for k, v in {
        LOG_LEVEL = "info"
        PORT      = "8080"
      } : { name = k, value = v }]
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

resource "aws_ecs_task_definition" "td009_foreach" {
  for_each = {
    api    = "nginx:latest"
    worker = "busybox:latest"
  }
  family                   = "c2cgap-td009-foreach-${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      name      = each.key
      image     = each.value
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-009"
  }
}

module "td009_modout_def" {
  source = "./td009_modout_src"
  name   = "app"
  image  = "nginx:latest"
}

resource "aws_ecs_task_definition" "td009_modout" {
  family                   = "c2cgap-td009-modout"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = module.td009_modout_def.json_map_encoded_list

  tags = {
    Rule = "TaskDefinition-009"
  }
}

module "td009_cplxlocal" {
  source = "./td009_cplxlocal_root"
}
