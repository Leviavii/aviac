# MySQL-015 — MySQL flexible server with public network access (no delegated subnet)

resource "azurerm_mysql_flexible_server" "c2c_mysql_015" {
  name                   = "c2c-mysql-015"
  resource_group_name    = azurerm_resource_group.c2c.name
  location               = azurerm_resource_group.c2c.location
  administrator_login    = "c2cadmin"
  administrator_password = "C2cP@ssw0rd123!"
  sku_name               = "B_Standard_B1ms"

  # Misconfig: public network access enabled by default (no delegated_subnet_id configured)
  # When delegated_subnet_id is not set, the server is publicly accessible
}
