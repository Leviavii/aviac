# Firewall-169 — Sensitive port should not be exposed to entire network
# Source fixture: cspm/builtinRules/Firewall-169/terraform/.../positive1.tf
# Uses a standalone azurerm_network_security_rule (preserves the triggering rule:
# protocol "*", destination port 61621, source 0.0.0.0/0).
resource "azurerm_network_security_group" "c2c_firewall_169" {
  name                = "c2c-firewall-169"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
}

resource "azurerm_network_security_rule" "c2c_firewall_169" {
  name                        = "c2c-firewall-169"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "61621"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.c2c.name
  network_security_group_name = azurerm_network_security_group.c2c_firewall_169.name
}
