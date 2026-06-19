# BackupService-006 — Recovery Services Vault with public network access enabled

resource "azurerm_recovery_services_vault" "c2c_backupservice_006" {
  name                          = "c2c-backupsvc-006"
  resource_group_name           = azurerm_resource_group.c2c.name
  location                      = azurerm_resource_group.c2c.location
  sku                           = "Standard"
  public_network_access_enabled = true
}
