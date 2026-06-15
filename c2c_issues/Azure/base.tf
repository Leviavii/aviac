# Shared infrastructure for all C2C policy resources.
# Every per-policy file references these.

resource "azurerm_resource_group" "c2c" {
  name     = "c2c-issues-rg"
  location = "eastus"
  tags = {
    purpose = "wiz-c2c-correlation"
    owner   = "avi.leviav"
  }
}

resource "azurerm_virtual_network" "c2c" {
  name                = "c2c-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
}

# General-purpose subnet.
resource "azurerm_subnet" "c2c" {
  name                 = "c2c-subnet"
  resource_group_name  = azurerm_resource_group.c2c.name
  virtual_network_name = azurerm_virtual_network.c2c.name
  address_prefixes     = ["10.10.1.0/24"]
}

# Dedicated subnet for private endpoints.
resource "azurerm_subnet" "c2c_pe" {
  name                 = "c2c-pe-subnet"
  resource_group_name  = azurerm_resource_group.c2c.name
  virtual_network_name = azurerm_virtual_network.c2c.name
  address_prefixes     = ["10.10.2.0/24"]
}
