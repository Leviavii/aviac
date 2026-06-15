# Firewall-018 — Network Security Group should restrict Oracle Database access (TCP - ports 1521, 1830, 2483 and 2484)
# Source fixture: cspm/builtinRules/Firewall-018/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_018" {
  name                = "c2c-firewall-018"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-oracle"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1521"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
