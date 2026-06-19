# PrivateLink-015 — ACR private endpoint without DNS zone group

resource "azurerm_container_registry" "c2c_privatelink_015" {
  name                = "c2cpl015acr"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  sku                 = "Premium"
  admin_enabled       = false
}

resource "azurerm_private_endpoint" "c2c_privatelink_015" {
  name                = "c2c-privatelink-015-pe"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  subnet_id           = azurerm_subnet.c2c_pe.id

  private_service_connection {
    name                           = "c2c-privatelink-015-psc"
    private_connection_resource_id = azurerm_container_registry.c2c_privatelink_015.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}
