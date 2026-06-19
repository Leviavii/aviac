# DataWorkload-019 — Data Factory private endpoint without DNS zone group

resource "azurerm_data_factory" "c2c_dataworkload_019" {
  name                = "c2c-datawl-019"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
}

resource "azurerm_private_endpoint" "c2c_dataworkload_019" {
  name                = "c2c-datawl-019-pe"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  subnet_id           = azurerm_subnet.c2c_pe.id

  private_service_connection {
    name                           = "c2c-datawl-019-psc"
    private_connection_resource_id = azurerm_data_factory.c2c_dataworkload_019.id
    is_manual_connection           = false
    subresource_names              = ["dataFactory"]
  }
}
