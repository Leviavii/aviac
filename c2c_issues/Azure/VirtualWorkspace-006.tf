# VirtualWorkspace-006 — Cognitive Account (Face API) with public network access enabled

resource "azurerm_cognitive_account" "c2c_virtualworkspace_006" {
  name                          = "c2c-virtualws-006"
  resource_group_name           = azurerm_resource_group.c2c.name
  location                      = azurerm_resource_group.c2c.location
  kind                          = "Face"
  sku_name                      = "S0"
  public_network_access_enabled = true
}
