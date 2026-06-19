# AppConfiguration-001 — App Configuration should have public network access disabled
# Triggers when public_network_access is "Enabled"

resource "azurerm_app_configuration" "c2c_appconfiguration_001" {
  name                  = "c2c-appcfg-001"
  resource_group_name   = azurerm_resource_group.c2c.name
  location              = azurerm_resource_group.c2c.location
  public_network_access = "Enabled"
}
