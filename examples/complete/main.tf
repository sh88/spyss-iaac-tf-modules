# Complete example showing how to use all modules together
# This example creates:
# - ECS cluster named "dev"
# - ECS Fargate service with Application Load Balancer
# - Route53 DNS record pointing to the ALB

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Data source for VPC (assumes you have an existing VPC)
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Data source for subnets (assumes you have existing subnets)
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  tags = {
    Tier = "Private"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  tags = {
    Tier = "Public"
  }
}

# Data source for Route53 hosted zone
data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}

# Create ECS cluster named "dev"
module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  cluster_name                = "dev"
  container_insights_enabled  = true
  default_capacity_provider   = "FARGATE"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# Create ECS Fargate service with ALB
module "ecs_fargate_service" {
  source = "../../modules/ecs-fargate-service"

  service_name     = var.service_name
  cluster_id       = module.ecs_cluster.cluster_id
  vpc_id           = var.vpc_id
  subnet_ids       = data.aws_subnets.private.ids
  alb_subnet_ids   = data.aws_subnets.public.ids

  container_name   = var.container_name
  container_image  = var.container_image
  container_port   = var.container_port

  task_cpu         = "512"
  task_memory      = "1024"
  desired_count    = 2

  assign_public_ip = false
  internal_alb     = false

  listener_port    = 80
  listener_protocol = "HTTP"

  alb_ingress_cidr_blocks = ["0.0.0.0/0"]

  health_check_path               = var.health_check_path
  health_check_interval           = 30
  health_check_timeout            = 5
  health_check_healthy_threshold  = 2
  health_check_unhealthy_threshold = 2
  health_check_matcher            = "200"

  log_retention_days = 7

  environment_variables = var.environment_variables

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# Create Route53 DNS record
module "route53" {
  source = "../../modules/route53"

  hosted_zone_id          = data.aws_route53_zone.this.zone_id
  record_name             = var.subdomain
  alb_dns_name            = module.ecs_fargate_service.alb_dns_name
  alb_zone_id             = module.ecs_fargate_service.alb_zone_id
  evaluate_target_health  = true
}
