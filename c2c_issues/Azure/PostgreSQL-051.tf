# PostgreSQL-051 — PostgreSQL flexible server with firewall rule (firewall rule removed from state)

resource "azurerm_postgresql_flexible_server" "c2c_postgresql_051" {
  name                   = "c2c-postgresql-051"
  resource_group_name    = azurerm_resource_group.c2c.name
  location               = azurerm_resource_group.c2c.location
  administrator_login    = "c2cadmin"
  administrator_password = "C2cP@ssw0rd123!"
  sku_name               = "GP_Standard_D2s_v3"
  version                = "15"

  # Misconfig: had firewall rule allowing wide IP range (firewall rule resource removed from state)
}
