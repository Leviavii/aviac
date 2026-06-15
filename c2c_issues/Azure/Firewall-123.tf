# Firewall-123 — Network Security Group should restrict RethinkDB access (TCP - ports 8080, 28015, 29015 and UDP - ports 28015, 29015)
# Source fixture: cspm/builtinRules/Firewall-123/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_123" {
  name                = "c2c-firewall-123"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "allow-rethinkdb"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-rethinkdb"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
