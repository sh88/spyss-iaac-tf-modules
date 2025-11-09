# Terraform IaaC Modules

A centralized repository for reusable Terraform modules across AWS, Azure, and GCP cloud providers.

## Overview

This repository contains Infrastructure as Code (IaaC) modules built with Terraform for managing resources across multiple cloud platforms. The modules are designed to be reusable, composable, and follow best practices for each cloud provider.

## Repository Structure

```
spyss-iaac-tf-modules/
├── aws/           # AWS-specific Terraform modules
├── azure/         # Azure-specific Terraform modules
├── gcp/           # GCP-specific Terraform modules
├── .gitignore     # Git ignore file for Terraform artifacts
└── README.md      # This file
```

## Cloud Providers

### AWS (Amazon Web Services)
Modules for AWS resources are located in the `aws/` directory. See [aws/README.md](aws/README.md) for details.

### Azure (Microsoft Azure)
Modules for Azure resources are located in the `azure/` directory. See [azure/README.md](azure/README.md) for details.

### GCP (Google Cloud Platform)
Modules for GCP resources are located in the `gcp/` directory. See [gcp/README.md](gcp/README.md) for details.

## Usage

Each module contains its own README with usage instructions, input variables, and outputs. To use a module:

1. Reference the module in your Terraform configuration
2. Provide required input variables
3. Configure the appropriate provider

Example:
```hcl
module "example" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//aws/module-name?ref=v1.0.0"
  
  # Module-specific variables
  name = "my-resource"
}
```

## Module Standards

All modules in this repository follow these standards:

- **Versioning**: Modules are versioned using Git tags
- **Documentation**: Each module includes a README.md with usage examples
- **Variables**: Input variables are clearly defined with descriptions and types
- **Outputs**: Output values are documented and provide useful information
- **Testing**: Modules should be tested before committing

## Contributing

To contribute a new module or update an existing one:

1. Create a new branch for your changes
2. Add or modify modules following the structure guidelines
3. Update documentation
4. Submit a pull request

## Getting Started

To start using these modules:

1. Clone this repository
2. Navigate to the appropriate cloud provider directory
3. Review available modules
4. Reference modules in your Terraform code

## Support

For issues or questions, please open an issue in this repository.