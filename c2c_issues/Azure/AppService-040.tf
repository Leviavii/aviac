# AppService-040 — Azure App Service web app authentication should be enabled
# Triggers when site_config has no auth_settings or auth block

resource "azurerm_service_plan" "c2c_appservice_040" {
  name                = "c2c-appservice-040-plan"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "c2c_appservice_040" {
  name                = "c2c-appservice-040"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  service_plan_id     = azurerm_service_plan.c2c_appservice_040.id

  site_config {}
}
