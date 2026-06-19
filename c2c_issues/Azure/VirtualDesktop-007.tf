# VirtualDesktop-007 — Virtual Desktop host pool with public network access enabled

resource "azurerm_virtual_desktop_host_pool" "c2c_virtualdesktop_007" {
  name                  = "c2c-vdpool-007"
  resource_group_name   = azurerm_resource_group.c2c.name
  location              = azurerm_resource_group.c2c.location
  type                  = "Pooled"
  load_balancer_type    = "BreadthFirst"
  public_network_access = "Enabled"
}
