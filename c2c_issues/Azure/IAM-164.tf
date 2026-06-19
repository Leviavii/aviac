# IAM-164 — Custom role with roleAssignments/write permission

data "azurerm_subscription" "c2c_iam_164" {}

resource "azurerm_role_definition" "c2c_iam_164" {
  name  = "c2c-iam-164-custom-role"
  scope = data.azurerm_subscription.c2c_iam_164.id

  permissions {
    actions = ["Microsoft.Authorization/roleAssignments/write"]
  }

  assignable_scopes = [
    data.azurerm_subscription.c2c_iam_164.id
  ]
}
