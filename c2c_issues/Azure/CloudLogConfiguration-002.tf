# CloudLogConfiguration-002 — Log Analytics Workspace internet ingestion should be disabled
# Triggers when internet_ingestion_enabled is true

resource "azurerm_log_analytics_workspace" "c2c_cloudlogconfiguration_002" {
  name                       = "c2c-cloudlog-002"
  resource_group_name        = azurerm_resource_group.c2c.name
  location                   = azurerm_resource_group.c2c.location
  internet_ingestion_enabled = true
  internet_query_enabled     = false
}
