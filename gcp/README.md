# GCP Terraform Modules

This directory contains Terraform modules for Google Cloud Platform (GCP) resources.

## Available Modules

Modules will be organized by GCP service or resource type. Each module will have its own directory.

### Module Structure

Each GCP module should follow this structure:
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
- gcloud CLI configured with appropriate credentials
- GCP project with necessary APIs enabled

### Provider Configuration

To use these modules, configure the GCP provider in your Terraform code:

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}
```

## Module Categories

Modules are organized by GCP service category:

- **Compute**: Compute Engine, Cloud Run, GKE, Cloud Functions
- **Networking**: VPC, Subnet, Firewall Rules, Cloud Load Balancing
- **Storage**: Cloud Storage, Persistent Disk, Filestore
- **Database**: Cloud SQL, Firestore, BigQuery, Bigtable
- **Security**: IAM, Secret Manager, KMS
- **Monitoring**: Cloud Monitoring, Cloud Logging, Cloud Trace

## Usage Example

```hcl
module "vpc" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//gcp/vpc?ref=v1.0.0"
  
  project_id   = "my-project-id"
  network_name = "my-vpc"
  
  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.0.0.0/24"
      subnet_region = "us-central1"
    }
  ]
}
```

## Best Practices

- Use specific module versions via Git tags
- Follow GCP naming conventions
- Label all resources appropriately
- Enable necessary APIs before creating resources
- Implement proper IAM and security configurations
- Use service accounts for authentication
- Enable Cloud Audit Logs

## Contributing

When adding new GCP modules:

1. Follow the standard module structure
2. Include comprehensive documentation
3. Provide usage examples
4. Test modules in a development environment
5. Follow GCP best practices and Cloud Architecture Framework principles
