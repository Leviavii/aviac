# Firewall-009 — Network Security Group access should only be allowed over specific ports 
# Source fixture: cspm/builtinRules/Firewall-009/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_009" {
  name                = "c2c-firewall-009"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-port-range"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000-9000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
