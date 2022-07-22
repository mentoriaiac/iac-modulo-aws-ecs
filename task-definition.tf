resource "aws_ecs_task_definition" "task_cluster" {
  family                   = var.family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = var.container1_name
      image     = var.container1_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      secrets = [{
        "name" : "DJANGO_SECRET_KEY",
        "valueFrom" : data.aws_ssm_parameter.main["django_secret_key"].arn
        },
        {
          "name" : "DJANGO_SETTINGS_MODULE",
          "valueFrom" : data.aws_ssm_parameter.main["django_settings_module"].arn
        },
        {
          "name" : "DJANGO_CONFIGURATION",
          "valueFrom" : data.aws_ssm_parameter.main["django_configuration"].arn
        },
        {
          "name" : "POSTGRES_PASSWORD",
          "valueFrom" : data.aws_ssm_parameter.main["postgres_password"].arn
        },
        {
          "name" : "POSTGRES_ENDPOINT",
          "valueFrom" : data.aws_ssm_parameter.main["postgres_endpoint"].arn
        },
        {
          "name" : "POSTGRES_USER",
          "valueFrom" : data.aws_ssm_parameter.main["postgres_user"].arn
        },
        {
          "name" : "POSTGRES_NAME",
          "valueFrom" : data.aws_ssm_parameter.main["postgres_name"].arn
        },
        #{
        # "name" : "SENTRY_DSN",
        # "valueFrom" : data.aws_ssm_parameter.main["sentry_dsn"].arn
        #},
        {
          "name" : "SPIDERMON_TELEGRAM_FAKE",
          "valueFrom" : data.aws_ssm_parameter.main["spidermon_telegram_fake"].arn
        },
        {
          "name" : "SPIDERMON_SENTRY_FAKE",
          "valueFrom" : data.aws_ssm_parameter.main["spidermon_sentry_fake"].arn
        },
        {
          "name" : "ACCESS_TOKEN_LIFETIME_IN_MINUTES",
          "valueFrom" : data.aws_ssm_parameter.main["access_token_lifetime_in_minutes"].arn
        },
        {
          "name" : "REFRESH_TOKEN_LIFETIME_IN_MINUTES",
          "valueFrom" : data.aws_ssm_parameter.main["refresh_token_lifetime_in_minutes"].arn
        },
        {
          "name" : "AWS_S3_BUCKET",
          "valueFrom" : data.aws_ssm_parameter.main["aws_s3_bucket"].arn
        },
        {
          "name" : "AWS_S3_BUCKET_FOLDER",
          "valueFrom" : data.aws_ssm_parameter.main["aws_s3_bucket_folder"].arn
        },
        {
          "name" : "aws_s3_region",
          "valueFrom" : data.aws_ssm_parameter.main["aws_s3_region"].arn
      }]

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
    }
  ])
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  tags = var.tags
}
