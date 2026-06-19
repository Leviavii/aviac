# CosmosDB-004 — Access key metadata writes enabled

resource "azurerm_cosmosdb_account" "c2c_cosmosdb_004" {
  name                = "c2c-cosmosdb-004"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  offer_type          = "Standard"

  # Misconfig: allows metadata operations using access keys
  access_key_metadata_writes_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.c2c.location
    failover_priority = 0
  }
}
