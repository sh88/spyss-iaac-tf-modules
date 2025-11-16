# create a ecr repository to push images and add tags and lifecycle policy to retain last 2 images filtered by tag prefix "prod-"

resource "aws_ecr_repository" "ecr_repository" {
  name = var.service

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

  tags = {
    environment  = var.environment
    service      = var.service
    organization = var.organization
    costcentre   = var.costcentre
    account_type = var.account_type
    created_by   = "terraform"
    email        = var.email
  }
}
resource "aws_ecr_lifecycle_policy" ecr_lifecycle_repository {
  repository = var.service

  policy     = <<EOF
  {
  "rules": [
    {
      "rulePriority": 1,
      "description": "Retain last 2 images with tag prefix 'prod-'",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["prod-"],
        "countType": "imageCountMoreThan",
        "countNumber": 2
      },
      "action": {
        "type": "expire"
      }
    },
    {
        "rulePriority": 2,
        "description": "Retain last 2 images with tag prefix 'dev-'
        "selection": {
            "tagStatus": "tagged",
            "tagPrefixList": ["dev-"],
            "countType": "imageCountMoreThan",
            "countNumber": 2
        },
        "action": {
            "type": "expire"
        }
    }
    {
      "rulePriority": 3,
      "description": "Delele all other images after a day",
      "selection": {
        "tagStatus": "any"
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}