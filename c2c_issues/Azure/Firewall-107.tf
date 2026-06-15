# Firewall-107 — Network Security Group should restrict Redis access (TCP - port 6379)
# Source fixture: cspm/builtinRules/Firewall-107/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_107" {
  name                = "c2c-firewall-107"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-redis"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6379"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
