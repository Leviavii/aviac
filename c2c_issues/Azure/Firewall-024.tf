# Firewall-024 — Network Security Group should restrict Telnet access (TCP - port 23)
# Source fixture: cspm/builtinRules/Firewall-024/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_024" {
  name                = "c2c-firewall-024"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-telnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "23"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
