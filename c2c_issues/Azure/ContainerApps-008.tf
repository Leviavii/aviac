# ContainerApps-008 — Azure Container Apps ingress should require authentication
# Triggers when ingress is public (external_enabled=true) with insecure transport

resource "azurerm_log_analytics_workspace" "c2c_containerapps_008" {
  name                = "c2c-containerapps-008-law"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "c2c_containerapps_008" {
  name                       = "c2c-containerapps-008-env"
  location                   = azurerm_resource_group.c2c.location
  resource_group_name        = azurerm_resource_group.c2c.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.c2c_containerapps_008.id
}

resource "azurerm_container_app" "c2c_containerapps_008" {
  name                         = "c2c-capp-008"
  resource_group_name          = azurerm_resource_group.c2c.name
  container_app_environment_id = azurerm_container_app_environment.c2c_containerapps_008.id
  revision_mode                = "Single"

  template {
    container {
      name   = "app-container"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "http"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
