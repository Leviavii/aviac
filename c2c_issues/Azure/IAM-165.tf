# IAM-165 — Custom role with wildcard (*) permissions

data "azurerm_subscription" "c2c_iam_165" {}

resource "azurerm_role_definition" "c2c_iam_165" {
  name  = "c2c-iam-165-custom-role"
  scope = data.azurerm_subscription.c2c_iam_165.id

  permissions {
    actions = ["*"]
  }

  assignable_scopes = [
    data.azurerm_subscription.c2c_iam_165.id
  ]
}
