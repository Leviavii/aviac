# PrivateLink-016 — EventHub namespace private endpoint without DNS zone group

resource "azurerm_eventhub_namespace" "c2c_privatelink_016" {
  name                = "c2c-pl016-ehns"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  sku                 = "Standard"
}

resource "azurerm_private_endpoint" "c2c_privatelink_016" {
  name                = "c2c-privatelink-016-pe"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  subnet_id           = azurerm_subnet.c2c_pe.id

  private_service_connection {
    name                           = "c2c-privatelink-016-psc"
    private_connection_resource_id = azurerm_eventhub_namespace.c2c_privatelink_016.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }
}
