# CosmosDB-012 — Cosmos DB private endpoint without DNS zone group

resource "azurerm_private_endpoint" "c2c_cosmosdb_012" {
  name                = "c2c-cosmosdb-012-pe"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  subnet_id           = azurerm_subnet.c2c_pe.id

  private_service_connection {
    name                           = "c2c-cosmosdb-012-psc"
    private_connection_resource_id = azurerm_cosmosdb_account.c2c_cosmosdb_006.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}
