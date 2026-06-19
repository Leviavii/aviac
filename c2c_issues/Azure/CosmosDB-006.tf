# CosmosDB-006 — Cosmos DB account with public network access enabled

resource "azurerm_cosmosdb_account" "c2c_cosmosdb_006" {
  name                          = "c2c-cosmosdb-006"
  resource_group_name           = azurerm_resource_group.c2c.name
  location                      = azurerm_resource_group.c2c.location
  offer_type                    = "Standard"
  public_network_access_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.c2c.location
    failover_priority = 0
  }
}
