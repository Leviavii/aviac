# InstanceGroup-026 — Azure Container Instances should not be publicly accessible
# Triggers when ip_address_type is "Public"

resource "azurerm_container_group" "c2c_instancegroup_026" {
  name                = "c2c-instgrp-026"
  location            = azurerm_resource_group.c2c.location
  resource_group_name = azurerm_resource_group.c2c.name
  ip_address_type     = "Public"
  dns_name_label      = "c2c-instgrp-026"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }
}
