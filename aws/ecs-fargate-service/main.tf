# ECS Task Definition
#resource "aws_ecs_task_definition" "this" {
#  family                   = var.service_name
#  network_mode             = "awsvpc"
#  requires_compatibilities = ["FARGATE"]
#  cpu                      = var.task_cpu
#  memory                   = var.task_memory
#  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
#  task_role_arn            = aws_iam_role.ecs_task_role.arn
#
#  container_definitions = jsonencode([
#    {
#      name      = var.container_name
#      image     = var.container_image
#      essential = true
#      portMappings = [
#        {
#          containerPort = var.container_port
#          protocol      = "tcp"
#        }
#      ]
#      logConfiguration = {
#        logDriver = "awslogs"
#        options = {
#          "awslogs-group"         = aws_cloudwatch_log_group.this.name
#          "awslogs-region"        = var.aws_region
#          "awslogs-stream-prefix" = "ecs"
#        }
#      }
#      environment = var.environment_variables
#    }
#  ])
#
#  tags = var.tags
#}

# ECS Service
resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_id
#  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.this]

  tags = var.tags
}

# Application Load Balancer
resource "aws_lb" "this" {
  name               = "${var.service_name}-alb"
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.alb_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}

# ALB Target Group
resource "aws_lb_target_group" "this" {
  name        = "${var.service_name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = var.health_check_healthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = var.tags
}

# ALB Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# Security Group for ALB
resource "aws_security_group" "alb" {
  name        = "${var.service_name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-alb-sg"
    }
  )
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.service_name}-ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-ecs-tasks-sg"
    }
  )
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.service_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM Role for ECS Task
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.service_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Data source for current region
data "aws_region" "current" {}
