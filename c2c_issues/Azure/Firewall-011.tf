# Firewall-011 — Network Security Group should restrict DNS access (TCP/UDP - port 53)
# Source fixture: cspm/builtinRules/Firewall-011/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_011" {
  name                = "c2c-firewall-011"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-dns-udp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
