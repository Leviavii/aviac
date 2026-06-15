# Firewall-106 — Network Security Group should restrict Memcached access (TCP/UDP - port 11211)
# Source fixture: cspm/builtinRules/Firewall-106/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_106" {
  name                = "c2c-firewall-106"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-memcached"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "11211"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
