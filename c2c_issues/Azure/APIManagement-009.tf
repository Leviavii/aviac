# APIManagement-009 — API Management Service protocol should be encrypted (Use https or wss)
# Triggers when an API uses insecure protocol (http or ws)

resource "azurerm_api_management" "c2c_apimanagement_009" {
  name                = "c2c-apim-009"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  publisher_name      = "Wiz C2C Publisher"
  publisher_email     = "c2c@wiz.io"
  sku_name            = "Consumption_0"
}

resource "azurerm_api_management_api" "c2c_apimanagement_009" {
  name                = "http-api"
  resource_group_name = azurerm_resource_group.c2c.name
  api_management_name = azurerm_api_management.c2c_apimanagement_009.name
  revision            = "1"
  display_name        = "HTTP API"
  path                = "http"
  protocols           = ["http"]
}
