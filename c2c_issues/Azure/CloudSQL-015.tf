# CloudSQL-015 — MS SQL Server with firewall rule allowing 0.0.0.0

resource "azurerm_mssql_server" "c2c_cloudsql_015" {
  name                         = "c2c-cloudsql-015"
  resource_group_name          = azurerm_resource_group.c2c.name
  location                     = azurerm_resource_group.c2c.location
  version                      = "12.0"
  administrator_login          = "c2cadmin"
  administrator_login_password = "C2cP@ssw0rd123!"
}

resource "azurerm_mssql_firewall_rule" "c2c_cloudsql_015" {
  name      = "allow-all"
  server_id = azurerm_mssql_server.c2c_cloudsql_015.id

  # Misconfig: firewall rule allowing 0.0.0.0 (public access)
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
