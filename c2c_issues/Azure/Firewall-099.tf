# Firewall-099 — Network Security Group should restrict mSQL (Mini SQL) access (TCP/UDP - port 4333)
# Source fixture: cspm/builtinRules/Firewall-099/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_099" {
  name                = "c2c-firewall-099"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-msql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4333"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-msql"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4333"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
