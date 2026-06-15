# Firewall-097 — Network Security Group should restrict SMB access (TCP - port 445)
# Source fixture: cspm/builtinRules/Firewall-097/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_097" {
  name                = "c2c-firewall-097"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-smb"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
