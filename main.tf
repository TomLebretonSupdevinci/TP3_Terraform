resource "azurerm_resource_group" "Pierre_and_Tom_group" {
  name = "Pierre_and_Tom_group"
  location = "Eastus"

  tags = {
    environment = "staging"
  }
}