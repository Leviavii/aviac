# Firewall-019 — Network Security Group should restrict NetBIOS access (TCP - ports 137, 139, UDP - ports 137, 138)
# Source fixture: cspm/builtinRules/Firewall-019/terraform/wiz/terraform/test/positive1.tf
resource "azurerm_network_security_group" "c2c_firewall_019" {
  name                = "c2c-firewall-019"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name

  security_rule {
    name                       = "allow-netbios-udp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "137"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}
