# Example GCP Module

This is a template/example module demonstrating the standard structure for GCP modules.

## Description

This example module creates a simple GCS (Google Cloud Storage) bucket with configurable settings. Use this as a template when creating new modules.

## Usage

```hcl
module "gcs_bucket" {
  source = "git::https://github.com/sh88/spyss-iaac-tf-modules.git//gcp/example-module?ref=v1.0.0"
  
  project_id  = "my-project-id"
  bucket_name = "my-unique-bucket-name"
  location    = "US"
  
  labels = {
    environment = "dev"
    project     = "example"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| google | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | GCP project ID | `string` | n/a | yes |
| bucket_name | Name of the GCS bucket | `string` | n/a | yes |
| location | Location for the GCS bucket | `string` | `"US"` | no |
| storage_class | Storage class for the bucket | `string` | `"STANDARD"` | no |
| labels | A map of labels to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | The name of the GCS bucket |
| bucket_url | The URL of the GCS bucket |
| bucket_self_link | The self link of the GCS bucket |

## Resources

| Name | Type |
|------|------|
| google_storage_bucket.main | resource |

## Example

See the [examples/basic](examples/basic/) directory for a complete example.
