# ecs.tf

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs_cluster"
}

data "template_file" "ctf_dashboard" {
  template = file("../modules/ecs/ctf_dashboard.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "ctf_dashboard" {
  family                   = "ctf-dashboard-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.ctf_dashboard.rendered
}

resource "aws_ecs_service" "ctf_dashboard" {
  name            = "ctf-dashboard-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.ctf_dashboard.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = concat(var.Private_Security_Group)
    subnets          = [var.Private_Subnet]
    assign_public_ip = true
  }

#  load_balancer {
#    target_group_arn = aws_alb_target_group.app.id
#    container_name   = "cb-app"
#    container_port   = var.app_port
#  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}

### roles

# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid = ""
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

## logs

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "ctf_dashboard_log_group" {
  name              = "/ecs/ctf-dashboard"
  retention_in_days = 30

  tags = {
    Name = "ctf-dashboard-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "ctf_dashboard_log_stream" {
  name           = "ctf-dashboard-log-stream"
  log_group_name = aws_cloudwatch_log_group.ctf_dashboard_log_group.name
}
