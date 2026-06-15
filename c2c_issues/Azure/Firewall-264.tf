# Firewall-264 — Network Security Group should restrict SSDP access (UDP - port 1900)
# Source fixture: cspm/builtinRules/Firewall-264/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_264" {
  name                = "c2c-firewall-264"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-ssdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "1900"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
