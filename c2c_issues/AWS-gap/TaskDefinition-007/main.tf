locals {
  td007_locals_containers = [
    {
      name      = "app"
      image     = "nginx:latest"
      cpu       = 256
      essential = true
    }
  ]
  td007_local_object_container = {
    name      = "app"
    image     = "nginx:latest"
    cpu       = 256
    essential = true
  }
}

resource "aws_ecs_task_definition" "td007_no_memory" {
  family = "c2cgap-td007-no-memory"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      cpu       = 256
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_fargate_task_memory" {
  family                   = "c2cgap-td007-fargate-task-memory"
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
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_reservation_only" {
  family = "c2cgap-td007-reservation-only"
  container_definitions = jsonencode([
    {
      name              = "app"
      image             = "nginx:latest"
      cpu               = 256
      memoryReservation = 256
      essential         = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_heredoc" {
  family                = "c2cgap-td007-heredoc"
  memory                = "512"
  container_definitions = <<DEFINITION
[
  {
    "name": "app",
    "image": "nginx:latest",
    "cpu": 256,
    "essential": true
  }
]
DEFINITION

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_locals" {
  family                = "c2cgap-td007-locals"
  memory                = "512"
  container_definitions = jsonencode(local.td007_locals_containers)

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_var_image" {
  family = "c2cgap-td007-var-image"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.account_id
      cpu       = 256
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_file" {
  family                = "c2cgap-td007-file"
  memory                = "512"
  container_definitions = file("${path.module}/td007_file_containers.json")

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_templatefile" {
  family = "c2cgap-td007-templatefile"
  memory = "512"
  container_definitions = templatefile("${path.module}/td007_templatefile_containers.json.tpl", {
    name  = "app"
    image = "nginx:latest"
  })

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "awscc_ecs_task_definition" "td007_awscc" {
  family                   = "c2cgap-td007-awscc"
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
      value = "TaskDefinition-007"
    }
  ]
}

resource "aws_ecs_task_definition" "td007_two_vars" {
  family = "c2cgap-td007-two-vars"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:${var.region}"
      cpu       = 256
      essential = true
      environment = [
        {
          name  = "ENV"
          value = var.vpc_id
        }
      ]
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_default_plus_unset_var" {
  family = "c2cgap-td007-default-plus-unset-var"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.account_id
      cpu       = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/c2cgap-td007"
          awslogs-region        = var.region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

data "aws_region" "td007_data_refs_region" {}

data "aws_caller_identity" "td007_data_refs_account" {}

resource "aws_ecs_task_definition" "td007_data_refs" {
  family = "c2cgap-td007-data-refs"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${data.aws_caller_identity.td007_data_refs_account.account_id}.dkr.ecr.${data.aws_region.td007_data_refs_region.name}.amazonaws.com/app:latest"
      cpu       = 256
      essential = true
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_cloudwatch_log_group" "td007_log_group_ref_logs" {
  name = "/ecs/c2cgap-td007-log-group-ref"

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_log_group_ref" {
  family = "c2cgap-td007-log-group-ref"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      cpu       = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.td007_log_group_ref_logs.name
          awslogs-region        = "us-east-2"
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_cloudwatch_log_group" "td007_two_resource_refs_logs" {
  name = "/ecs/c2cgap-td007-two-resource-refs"

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecr_repository" "td007_two_resource_refs_repo" {
  name = "c2cgap-td007-two-resource-refs"

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_two_resource_refs" {
  family = "c2cgap-td007-two-resource-refs"
  memory = "512"
  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.td007_two_resource_refs_repo.repository_url}:latest"
      cpu       = 256
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.td007_two_resource_refs_logs.name
          awslogs-region        = "us-east-2"
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])

  tags = {
    Rule = "TaskDefinition-007"
  }
}

resource "aws_ecs_task_definition" "td007_local_object" {
  family                = "c2cgap-td007-local-object"
  memory                = "512"
  container_definitions = jsonencode([local.td007_local_object_container])

  tags = {
    Rule = "TaskDefinition-007"
  }
}
