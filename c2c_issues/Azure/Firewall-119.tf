# Firewall-119 — Network Security Group should restrict ArangoDB access (TCP and UDP - port 8529)
# Source fixture: cspm/builtinRules/Firewall-119/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_119" {
  name                = "c2c-firewall-119"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-arangodb-tcp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8529"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
