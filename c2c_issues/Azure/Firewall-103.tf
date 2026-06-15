# Firewall-103 — Network Security Group should restrict Cassandra access (TCP - ports 7000, 7001, 7199, 9042, 9142 and 9160)
# Source fixture: cspm/builtinRules/Firewall-103/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_103" {
  name                = "c2c-firewall-103"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-cassandra"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7000"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
