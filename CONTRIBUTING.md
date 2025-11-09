# Contributing to Terraform IaaC Modules

Thank you for your interest in contributing to our Terraform modules repository! This document provides guidelines and best practices for contributing.

## Table of Contents

- [Getting Started](#getting-started)
- [Module Standards](#module-standards)
- [Development Workflow](#development-workflow)
- [Module Structure](#module-structure)
- [Documentation Requirements](#documentation-requirements)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a new branch for your changes
4. Make your changes following the guidelines below
5. Test your changes thoroughly
6. Submit a pull request

## Module Standards

All modules must adhere to these standards:

### Naming Conventions

- **Module names**: Use lowercase with hyphens (e.g., `vpc`, `compute-instance`)
- **Variable names**: Use lowercase with underscores (e.g., `vpc_cidr`, `instance_type`)
- **Resource names**: Use descriptive names that reflect their purpose

### File Structure

Every module must include:

```
module-name/
├── main.tf           # Required: Main resource definitions
├── variables.tf      # Required: Input variable declarations
├── outputs.tf        # Required: Output value declarations
├── versions.tf       # Required: Terraform and provider versions
├── README.md         # Required: Module documentation
└── examples/         # Recommended: Usage examples
    └── basic/
        ├── main.tf
        └── README.md
```

### Terraform Version

- Minimum Terraform version: `>= 1.0`
- Specify version constraints in `versions.tf`

### Code Style

- Use 2 spaces for indentation
- Run `terraform fmt` before committing
- Follow HashiCorp's [Terraform Style Guide](https://www.terraform.io/docs/language/syntax/style.html)

## Development Workflow

1. **Plan Your Module**
   - Identify the resources to be managed
   - Define input variables and outputs
   - Consider module composability

2. **Create Module Files**
   - Start with `versions.tf` to define version constraints
   - Create `variables.tf` with all input variables
   - Implement resources in `main.tf`
   - Define outputs in `outputs.tf`

3. **Document Your Module**
   - Create comprehensive README.md
   - Document all variables and outputs
   - Provide usage examples

4. **Test Your Module**
   - Test in a development environment
   - Verify resource creation and destruction
   - Test with different input combinations

## Module Structure

### versions.tf

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
```

### variables.tf

```hcl
variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
```

### outputs.tf

```hcl
output "resource_id" {
  description = "The ID of the created resource"
  value       = aws_resource.main.id
}
```

### main.tf

```hcl
resource "aws_resource" "main" {
  name = var.name
  
  tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}
```

## Documentation Requirements

Every module's README.md must include:

1. **Module Description**: Brief overview of what the module does
2. **Usage Example**: Code snippet showing how to use the module
3. **Requirements**: Terraform version, provider versions
4. **Inputs**: Table of all input variables with descriptions, types, defaults
5. **Outputs**: Table of all outputs with descriptions
6. **Resources**: List of resources created by the module

### README Template

```markdown
# Module Name

Brief description of what this module does.

## Usage

\`\`\`hcl
module "example" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//provider/module-name?ref=v1.0.0"
  
  name = "my-resource"
}
\`\`\`

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Resource name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID |

## Resources

| Name | Type |
|------|------|
| aws_resource.main | resource |
```

## Testing

Before submitting your module:

1. **Format Check**: Run `terraform fmt -recursive`
2. **Validation**: Run `terraform validate`
3. **Plan**: Test with `terraform plan` in examples/
4. **Apply**: Create resources in a test environment
5. **Destroy**: Clean up with `terraform destroy`

### Testing Checklist

- [ ] Module syntax is valid
- [ ] All variables work as expected
- [ ] Outputs return correct values
- [ ] Resources are created successfully
- [ ] Resources can be destroyed cleanly
- [ ] Module works with minimum required variables
- [ ] Module works with all optional variables

## Submitting Changes

1. **Format your code**: `terraform fmt -recursive`
2. **Commit your changes** with a clear message:
   ```
   Add AWS VPC module with subnet configuration
   
   - Created VPC module with configurable CIDR
   - Added subnet creation with availability zone support
   - Included example configuration
   ```
3. **Push to your fork**
4. **Create a Pull Request** with:
   - Clear description of changes
   - Reference to any related issues
   - Test results or validation steps performed

## Best Practices

### Security

- Never commit secrets, keys, or credentials
- Use secure defaults (encryption enabled, etc.)
- Follow principle of least privilege for IAM/permissions
- Document security considerations

### Maintainability

- Keep modules focused and single-purpose
- Avoid hardcoding values
- Use variables for configurable options
- Provide sensible defaults
- Comment complex logic

### Reusability

- Make modules generic and flexible
- Use variables for customization
- Avoid environment-specific values
- Document assumptions and limitations

## Questions?

If you have questions or need help, please:
- Open an issue for discussion
- Review existing modules for examples
- Check Terraform documentation

Thank you for contributing!
