# Firewall-015 — Network Security Group should restrict ICMP access
# Source fixture: cspm/builtinRules/Firewall-015/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_015" {
  name                = "c2c-firewall-015"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-icmp"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 100
    direction                  = "Inbound"
  }
}
