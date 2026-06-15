# Firewall-010 — Network Security Group should restrict CIFS access (UDP - ports 137, 138, 445, TCP - ports 139, 445)
# Source fixture: cspm/builtinRules/Firewall-010/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_010" {
  name                = "c2c-firewall-010"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-cifs-udp-137"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "137"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
