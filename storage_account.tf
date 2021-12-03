
resource "azurerm_storage_account" "default" {
  name                      = "storage_account_daimler_dev"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}