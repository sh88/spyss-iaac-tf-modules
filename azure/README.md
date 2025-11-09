# Azure Terraform Modules

This directory contains Terraform modules for Microsoft Azure resources.

## Available Modules

Modules will be organized by Azure service or resource type. Each module will have its own directory.

### Module Structure

Each Azure module should follow this structure:
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
- Azure CLI configured with appropriate credentials
- Azure subscription with necessary permissions

### Provider Configuration

To use these modules, configure the Azure provider in your Terraform code:

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

## Module Categories

Modules are organized by Azure service category:

- **Compute**: Virtual Machines, App Service, Container Instances, AKS
- **Networking**: Virtual Network, Subnet, NSG, Application Gateway, Load Balancer
- **Storage**: Storage Account, Blob Storage, File Share, Disk
- **Database**: SQL Database, CosmosDB, MySQL, PostgreSQL
- **Security**: Key Vault, Managed Identity, RBAC
- **Monitoring**: Monitor, Log Analytics, Application Insights

## Usage Example

```hcl
module "resource_group" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//azure/resource-group?ref=v1.0.0"
  
  name     = "my-resource-group"
  location = "East US"
  
  tags = {
    Environment = "production"
  }
}
```

## Best Practices

- Use specific module versions via Git tags
- Follow Azure naming conventions
- Tag all resources appropriately
- Use resource groups to organize resources
- Implement proper security configurations
- Enable diagnostic settings and logging
- Use Azure Policy for governance

## Contributing

When adding new Azure modules:

1. Follow the standard module structure
2. Include comprehensive documentation
3. Provide usage examples
4. Test modules in a development environment
5. Follow Azure best practices and Cloud Adoption Framework principles
