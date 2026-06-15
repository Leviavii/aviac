# Firewall-109 — Network Security Group should restrict etcd access (TCP - port 2379)
# Source fixture: cspm/builtinRules/Firewall-109/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_109" {
  name                = "c2c-firewall-109"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-etcd"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2379"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
