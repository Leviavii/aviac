# Firewall-021 — Network Security Group should restrict PostgreSQL access (TCP - port 5432)
# Source fixture: cspm/builtinRules/Firewall-021/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_021" {
  name                = "c2c-firewall-021"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location

  security_rule {
    name                       = "AllowPostgreSQL"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
