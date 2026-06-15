# Firewall-124 — Network Security Group should restrict Solr access (TCP - ports 7574, 8983)
# Source fixture: cspm/builtinRules/Firewall-124/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_124" {
  name                = "c2c-firewall-124"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "AllowSolr7574"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7574"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
