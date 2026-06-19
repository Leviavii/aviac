# CosmosDB-005 — Public network access enabled with 0.0.0.0 IP filter

resource "azurerm_cosmosdb_account" "c2c_cosmosdb_005" {
  name                = "c2c-cosmosdb-005"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  offer_type          = "Standard"
  kind                = "MongoDB"

  # Misconfig: public access with 0.0.0.0 in IP filter
  public_network_access_enabled = true
  ip_range_filter               = "0.0.0.0,1.2.3.4"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level = "Strong"
  }

  geo_location {
    location          = azurerm_resource_group.c2c.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "EnableMongo"
  }
}
