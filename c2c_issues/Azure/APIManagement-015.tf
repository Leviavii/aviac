# APIManagement-015 — Azure API Management Service should have public network access disabled
# Triggers when public_network_access_enabled is true

resource "azurerm_api_management" "c2c_apimanagement_015" {
  name                          = "c2c-apim-015"
  location                      = azurerm_resource_group.c2c.location
  resource_group_name           = azurerm_resource_group.c2c.name
  publisher_name                = "Wiz C2C Publisher"
  publisher_email               = "c2c@wiz.io"
  sku_name                      = "Consumption_0"
  public_network_access_enabled = true
}
