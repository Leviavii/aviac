# PrivateLink-018 — Automation Account webhook private endpoint without DNS zone group

resource "azurerm_automation_account" "c2c_privatelink_018" {
  name                = "c2c-pl018-auto"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  sku_name            = "Basic"
}

resource "azurerm_private_endpoint" "c2c_privatelink_018" {
  name                = "c2c-privatelink-018-pe"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  subnet_id           = azurerm_subnet.c2c_pe.id

  private_service_connection {
    name                           = "c2c-privatelink-018-psc"
    private_connection_resource_id = azurerm_automation_account.c2c_privatelink_018.id
    is_manual_connection           = false
    subresource_names              = ["Webhook"]
  }
}
