resource "azurerm_storage_account" "storage_account" {
  name                     = "pierreandtomstoragetp2"
  resource_group_name      = "Pierre_and_Tom_group"
  location                 = "Eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

