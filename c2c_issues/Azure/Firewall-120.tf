# Firewall-120 — Network Security Group should restrict CouchDB access (TCP - port 5984)
# Source fixture: cspm/builtinRules/Firewall-120/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_120" {
  name                = "c2c-firewall-120"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-couchdb"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5984"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
