resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location

  tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
      Module    = "example-module"
    }
  )
}
