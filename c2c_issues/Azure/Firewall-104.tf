# Firewall-104 — Network Security Group should restrict Elastic Search access (TCP - port 9200 and 9300)
# Source fixture: cspm/builtinRules/Firewall-104/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_104" {
  name                = "c2c-firewall-104"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-public-elasticsearch-9200"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9200"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
