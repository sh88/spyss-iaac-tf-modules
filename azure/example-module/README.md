# Example Azure Module

This is a template/example module demonstrating the standard structure for Azure modules.

## Description

This example module creates a simple Azure Resource Group with configurable settings. Use this as a template when creating new modules.

## Usage

```hcl
module "resource_group" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//azure/example-module?ref=v1.0.0"
  
  name     = "my-resource-group"
  location = "East US"
  
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the resource group | `string` | n/a | yes |
| location | Azure region where the resource group will be created | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | The ID of the resource group |
| resource_group_name | The name of the resource group |
| location | The location of the resource group |

## Resources

| Name | Type |
|------|------|
| azurerm_resource_group.main | resource |

## Example

See the [examples/basic](examples/basic/) directory for a complete example.
