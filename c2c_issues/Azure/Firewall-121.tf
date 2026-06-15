# Firewall-121 — Network Security Group should restrict Neo4J access (TCP - ports 7473, 7474 and UDP - port 7473)
# Source fixture: cspm/builtinRules/Firewall-121/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_121" {
  name                = "c2c-firewall-121"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-neo4j"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7473"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-neo4j"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7473"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
