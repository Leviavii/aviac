# Firewall-016 — Network Security Group should restrict MongoDB access (TCP - ports 27017-27020)
# Source fixture: cspm/builtinRules/Firewall-016/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_016" {
  name                = "c2c-firewall-016"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-mongodb"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "27017"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
