# Firewall-166 — Network Security Group should restrict POP3 access (TCP - ports 110, 995 and UDP - ports 110, 995)
# Source fixture: cspm/builtinRules/Firewall-166/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_166" {
  name                = "c2c-firewall-166"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-pop3"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "110"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
