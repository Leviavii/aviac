# VPC-148 — Subnet without network security group

resource "azurerm_subnet" "c2c_vpc_148" {
  name                 = "c2c-vpc-148"
  resource_group_name  = azurerm_resource_group.c2c.name
  virtual_network_name = azurerm_virtual_network.c2c.name
  address_prefixes     = ["10.10.3.0/24"]
}
