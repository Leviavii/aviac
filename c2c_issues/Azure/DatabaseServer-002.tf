# DatabaseServer-002 — Redis cache does not use a private endpoint

resource "azurerm_redis_cache" "c2c_databaseserver_002" {
  name                = "c2c-dbserver-002"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"

  # Misconfig: no private endpoint configured (requires Standard/Premium SKU)
  # Basic SKU doesn't support private endpoints
}
