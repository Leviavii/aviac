# Firewall-012 — Network Security Group should restrict FTP access (TCP - ports 20, 21)
# Source fixture: cspm/builtinRules/Firewall-012/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_012" {
  name                = "c2c-firewall-012"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-ftp-data"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "20"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
