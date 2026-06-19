# VirtualDesktop-008 — Virtual Desktop workspace with public network access enabled

resource "azurerm_virtual_desktop_workspace" "c2c_virtualdesktop_008" {
  name                          = "c2c-vdws-008"
  resource_group_name           = azurerm_resource_group.c2c.name
  location                      = azurerm_resource_group.c2c.location
  friendly_name                 = "C2C Virtual Desktop Workspace"
  public_network_access_enabled = true
}
