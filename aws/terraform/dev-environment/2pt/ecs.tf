resource "aws_ecs_cluster" "main" {
  name = "${var.cluster_name}"
}

resource "aws_ecr_repository" "default"{
    name = "diaspora"
}

resource "aws_ecs_task_definition" "dev-diaspora" {
  family                = "dev-diaspora"
  network_mode          = "bridge"
  container_definitions = <<EOF
  [
      {
       "memoryReservation": 512,
       "image": "${aws_ecr_repository.default.repository_url}:latest",
       "name": "dev-diaspora",
       "dnsSearchDomains": null,
       "logConfiguration": {
           "logDriver": "awslogs",
            "options": {
               "awslogs-group": "/ecs/dev-diaspora",
               "awslogs-region": "us-east-1",
               "awslogs-stream-prefix": "ecs"
             }
           },
        "entryPoint": null,
        "portMappings": [
            {
             "containerPort": 80,
             "hostPort": 0,
             "protocol": "tcp"
            }
        ],
        "cpu": 0,
        "environment": [
         {  "name": "DB_HOST",  "value": "SET YOUR DB DNS"  },
         {  "name": "DB_PASSWORD",  "value": "SET YOUR DB PASSWORD"  },
         {  "name": "DB_PORT",  "value": "5432"  },
         {  "name": "DB_USER",  "value": "SET YOUR USER DB"  },
         {  "name": "DATABASE_YML",  "value": ""  },
         {  "name": "URL",  "value": "http:// SET YOUR DNS"  },
         {  "name": "REQUIRE_SSL",  "value": "false"  },
         {  "name": "ENABLE",  "value": "true"  },
         {  "name": "KEY",  "value": ""  },
         {  "name": "SECRET",  "value": ""  },
         {  "name": "BUCKET",  "value": "SET YOUR S3 BUCKET"  },
         {  "name": "REGION",  "value": "us-east-1"  },
         {  "name": "RAILS_ENV",  "value": "development"  },
         {  "name": "REDIS",  "value": "SET YOUR REDIS DNS"  }
        ],
          "disableNetworking": false
         }
       ]
  EOF
  task_role_arn = "${aws_iam_role.docker-dev-diaspora.name}"
}

resource "aws_cloudwatch_log_group" "default" {
  name = "/ecs/dev-diaspora"
}

data "aws_alb_target_group" "dev-alb" {
  name = "dev-diaspora"
}

resource "aws_ecs_service" "test" {
  name            = "dev-diaspora"
  cluster         = "${aws_ecs_cluster.main.id}"
  desired_count   = 0
  iam_role        = "SET YOUR FULL ARN TO ROLE AWSServiceRoleForECS"
  deployment_maximum_percent         = "100"
  deployment_minimum_healthy_percent = "50"
  task_definition = "${aws_ecs_task_definition.dev-diaspora.arn}"
  depends_on      = ["aws_ecs_task_definition.dev-diaspora"]

  load_balancer {
    target_group_arn = "${data.aws_alb_target_group.dev-alb.id}"
    container_name   = "dev-diaspora"
    container_port   = "80"
  }
}

resource "aws_s3_bucket" "main" {
  bucket = "dev-diaspora-img"
  acl    = "private"
}
