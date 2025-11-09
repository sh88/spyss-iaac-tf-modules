resource "google_storage_bucket" "main" {
  name          = var.bucket_name
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  labels = merge(
    var.labels,
    {
      managed_by = "terraform"
      module     = "example-module"
    }
  )

  force_destroy = false
}
