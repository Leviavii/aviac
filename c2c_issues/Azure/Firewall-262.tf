# Firewall-262 — Network Security Group should restrict SNMP access (UDP - port 161)
# Source fixture: cspm/builtinRules/Firewall-262/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_262" {
  name                = "c2c-firewall-262"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-snmp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "161"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-snmp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "161"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
