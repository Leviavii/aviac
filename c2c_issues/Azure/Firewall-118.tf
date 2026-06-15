# Firewall-118 — Network Security Group should restrict MaxDB access (TCP - port 7210)
# Source fixture: cspm/builtinRules/Firewall-118/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_118" {
  name                = "c2c-firewall-118"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-maxdb-public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7210"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
