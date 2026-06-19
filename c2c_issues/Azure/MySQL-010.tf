# MySQL-010 — MySQL flexible server with firewall rule allowing 0.0.0.0

resource "azurerm_mysql_flexible_server" "c2c_mysql_010" {
  name                   = "c2c-mysql-010"
  resource_group_name    = azurerm_resource_group.c2c.name
  location               = azurerm_resource_group.c2c.location
  administrator_login    = "c2cadmin"
  administrator_password = "C2cP@ssw0rd123!"
  sku_name               = "B_Standard_B1ms"

  # Misconfig: has firewall rule allowing 0.0.0.0 (firewall rule resource removed from state)
}
