resource "azurerm_resource_group" "Pierre_and_Tom_group" {
  name = "Pierre_and_Tom_group"
  location = "Eastus"

  tags = {
    environment = "staging"
  }
}

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

resource "azurerm_virtual_network" "virtual_network_tp3" {
  name                = "virtual_network_tp3"
  address_space       = ["10.0.0.0/16"]
  location            = "Eastus"
  resource_group_name = "Pierre_and_Tom_group"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_subnet" "subnet_tp3" {
  name                 = "internal"
  resource_group_name  = "Pierre_and_Tom_group"
  virtual_network_name = "virtual_network_tp3"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "network_interface_tp3" {
  name                = "interface1_tp3"
  location            = "Eastus"
  resource_group_name = "Pierre_and_Tom_group"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_tp3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id

  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "vm_public_ip"
  resource_group_name = "Pierre_and_Tom_group"
  location            = "Eastus"
  allocation_method   = "Dynamic"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "vm-test-terraform-tp3"
  resource_group_name = "Pierre_and_Tom_group"
  location            = "Eastus"
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.network_interface_tp3.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/rsa_tp_terraform.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "staging"
  }
}