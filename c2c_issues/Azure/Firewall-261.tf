# Firewall-261 — Network Security Group should restrict NTP access (UDP - port 123)
# Source fixture: cspm/builtinRules/Firewall-261/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_261" {
  name                = "c2c-firewall-261"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-ntp-from-internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-ntp-from-internet"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
