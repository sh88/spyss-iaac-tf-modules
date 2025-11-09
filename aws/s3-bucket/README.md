# Example AWS Module

This is a template/example module demonstrating the standard structure for AWS modules.

## Description

This example module creates a simple S3 bucket with configurable settings. Use this as a template when creating new modules.

## Usage

```hcl
module "s3_bucket" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//aws/example-module?ref=v1.0.0"
  
  bucket_name = "my-unique-bucket-name"
  
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
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| enable_versioning | Enable versioning for the bucket | `bool` | `false` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the S3 bucket |
| bucket_arn | The ARN of the S3 bucket |

## Resources

| Name | Type |
|------|------|
| aws_s3_bucket.main | resource |
| aws_s3_bucket_versioning.main | resource |

## Example

See the [examples/basic](examples/basic/) directory for a complete example.
