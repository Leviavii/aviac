# Firewall-025 — Network Security Group should restrict VNC access (TCP - ports 5500, 5800 and 5900)
# Source fixture: cspm/builtinRules/Firewall-025/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_025" {
  name                = "c2c-firewall-025"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-vnc"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5900"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-vnc"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5900"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
