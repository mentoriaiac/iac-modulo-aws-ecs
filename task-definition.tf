resource "aws_ecs_task_definition" "task_cluster" {
  family                   = var.family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  network_mode             = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = var.container1_name
      image     = var.container1_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      environment = [{
        "name": "POSTGRES_DB",
        "value": "mariaquiteria"
      },
      {
        "name": "POSTGRES_USER",
        "value": "postgres"
      },
      {
        "name": "POSTGRES_PASSWORD"
        "value": "postgres"
      },
       {
        "name": "DATABASE_HOST",
        "value": "db"
      },
      {
        "name": "SPIDERMON_TELEGRAM_FAKE",
        "value":  "True"
      },
      {
        "name":"SPIDERMON_SENTRY_FAKE",
        "value": "True"
      },
      {
        "name": "DJANGO_SETTINGS_MODULE",
        "value": "web.settings"
      },
      {
        "name": "DJANGO_CONFIGURATION",
        "value": "Dev"
      },
      {
        "name": "DJANGO_SECRET_KEY",
        "value": "dont-tell-anybody"
      },
      {
        "name": "ACCESS_TOKEN_LIFETIME_IN_MINUTES",
        "value": "60"
      },
      {
        "name": "REFRESH_TOKEN_LIFETIME_IN_MINUTES",
        "value": "60"
      }
      ]
        
      portMappings = [
        {
          containerPort = var.container1_port
          hostPort      = var.container1_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.main.name}"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "${var.container1_name}"

        }
      }

      dependsOn = [
    {
        "containerName": "db",
        "condition": "START"
    }
]
    },
    {
      name      = var.container2_name
      image     = var.container2_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      environment = [{
        "name": "POSTGRES_DB",
        "value": "mariaquiteria"
      },
      {
        "name": "POSTGRES_USER",
        "value": "postgres"
      },
      {
        "name": "POSTGRES_PASSWORD",
        "value": "postgres"
      }
      ]
      portMappings = [
        {
          containerPort = var.container2_port
          hostPort      = var.container2_port
        }
      ]
    },
    {
      name      = var.container3_name
      image     = var.container3_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container3_port
          hostPort      = var.container3_port
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  tags = var.tags
}
