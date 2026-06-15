# Firewall-108 — Network Security Group should restrict Kibana access (TCP - port 5601)
# Source fixture: cspm/builtinRules/Firewall-108/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_108" {
  name                = "c2c-firewall-108"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-kibana"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5601"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
