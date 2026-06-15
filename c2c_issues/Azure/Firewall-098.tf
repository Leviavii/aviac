# Firewall-098 — Network Security Group should restrict MySQL access (TCP - port 3306)
# Source fixture: cspm/builtinRules/Firewall-098/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_098" {
  name                = "c2c-firewall-098"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-mysql-internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
