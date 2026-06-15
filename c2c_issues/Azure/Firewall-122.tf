# Firewall-122 — Network Security Group should restrict Riak access (TCP - ports 8087, 8098)
# Source fixture: cspm/builtinRules/Firewall-122/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_122" {
  name                = "c2c-firewall-122"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-riak-8087"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8087"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
