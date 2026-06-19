# MessagingService-067 — Relay hybrid connection without client authorization

resource "azurerm_relay_namespace" "c2c_messagingservice_067" {
  name                = "c2c-msgsvc-067"
  resource_group_name = azurerm_resource_group.c2c.name
  location            = azurerm_resource_group.c2c.location
  sku_name            = "Standard"
}

resource "azurerm_relay_hybrid_connection" "c2c_messagingservice_067" {
  name                 = "noncompliant-hybrid-conn"
  resource_group_name  = azurerm_resource_group.c2c.name
  relay_namespace_name = azurerm_relay_namespace.c2c_messagingservice_067.name

  # Misconfig: client authorization not required
  requires_client_authorization = false
}
