# AWS Terraform Modules

This directory contains Terraform modules for Amazon Web Services (AWS) resources.

## Available Modules

Modules will be organized by AWS service or resource type. Each module will have its own directory.

### Module Structure

Each AWS module should follow this structure:
```
module-name/
├── main.tf           # Main resource definitions
├── variables.tf      # Input variable declarations
├── outputs.tf        # Output value declarations
├── versions.tf       # Terraform and provider version constraints
├── README.md         # Module documentation
└── examples/         # Usage examples
    └── basic/
        ├── main.tf
        └── README.md
```

## Getting Started

### Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

### Provider Configuration

To use these modules, configure the AWS provider in your Terraform code:

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

## Module Categories

Modules are organized by AWS service category:

- **Compute**: EC2, Lambda, ECS, EKS
- **Networking**: VPC, Subnet, Security Groups, Load Balancers
- **Storage**: S3, EBS, EFS
- **Database**: RDS, DynamoDB, ElastiCache
- **Security**: IAM, KMS, Secrets Manager
- **Monitoring**: CloudWatch, CloudTrail

## Usage Example

```hcl
module "vpc" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//aws/vpc?ref=v1.0.0"
  
  vpc_cidr = "10.0.0.0/16"
  name     = "my-vpc"
  
  tags = {
    Environment = "production"
  }
}
```

## Best Practices

- Use specific module versions via Git tags
- Follow AWS naming conventions
- Tag all resources appropriately
- Use data sources for existing resources
- Implement proper security configurations
- Enable encryption where applicable

## Contributing

When adding new AWS modules:

1. Follow the standard module structure
2. Include comprehensive documentation
3. Provide usage examples
4. Test modules in a development environment
5. Follow AWS best practices and Well-Architected Framework principles
