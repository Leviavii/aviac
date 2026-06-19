# ContainerApps-007 — Azure Container Apps should have managed identity enabled
# Triggers when container app has no identity block

resource "azurerm_log_analytics_workspace" "c2c_containerapps_007" {
  name                = "c2c-containerapps-007-law"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "c2c_containerapps_007" {
  name                       = "c2c-containerapps-007-env"
  location                   = azurerm_resource_group.c2c.location
  resource_group_name        = azurerm_resource_group.c2c.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.c2c_containerapps_007.id
}

resource "azurerm_container_app" "c2c_containerapps_007" {
  name                         = "c2c-capp-007"
  resource_group_name          = azurerm_resource_group.c2c.name
  container_app_environment_id = azurerm_container_app_environment.c2c_containerapps_007.id
  revision_mode                = "Single"

  template {
    container {
      name   = "app-container"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
