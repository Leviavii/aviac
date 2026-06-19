# PostgreSQL-033 — PostgreSQL flexible server with public network access enabled

resource "azurerm_postgresql_flexible_server" "c2c_postgresql_033" {
  name                   = "c2c-postgresql-033"
  resource_group_name    = azurerm_resource_group.c2c.name
  location               = azurerm_resource_group.c2c.location
  administrator_login    = "c2cadmin"
  administrator_password = "C2cP@ssw0rd123!"
  sku_name               = "GP_Standard_D2s_v3"
  version                = "14"

  # Misconfig: public network access explicitly enabled
  public_network_access_enabled = true
}
