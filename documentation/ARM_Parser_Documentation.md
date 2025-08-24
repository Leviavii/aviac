# ARM Template Parser Documentation

## Template Organization and Function Preservation

ARM templates are reorganized into a consistent, readable format while preserving all original template functions and logic. This ensures you can see both the clean structure and the complete template functionality.

**Before:**
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountName": {
      "type": "string",
      "defaultValue": "mystorageaccount001"
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]"
    }
  },
  "variables": {
    "uniqueStorageName": "[concat(parameters('storageAccountName'), uniqueString(resourceGroup().id))]",
    "storageContainerName": "data"
  },
  "resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2021-04-01",
      "name": "[variables('uniqueStorageName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "StorageV2",
      "properties": {
        "accessTier": "Hot"
      }
    }
  ],
  "outputs": {
    "storageAccountId": {
      "type": "string",
      "value": "[resourceId('Microsoft.Storage/storageAccounts', variables('uniqueStorageName'))]"
    }
  }
}
```

**After (Parsed):**
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "outputs": {
    "storageAccountId": {
      "type": "string",
      "value": "[resourceId('Microsoft.Storage/storageAccounts', variables('uniqueStorageName'))]"
    }
  },
  "parameters": {
    "location": {
      "defaultValue": "[resourceGroup().location]",
      "type": "string"
    },
    "storageAccountName": {
      "defaultValue": "mystorageaccount001",
      "type": "string"
    }
  },
  "resources": [
    {
      "apiVersion": "2021-04-01",
      "kind": "StorageV2",
      "location": "[parameters('location')]",
      "name": "[variables('uniqueStorageName')]",
      "properties": {
        "accessTier": "Hot"
      },
      "sku": {
        "name": "Standard_LRS"
      },
      "type": "Microsoft.Storage/storageAccounts"
    }
  ],
  "variables": {
    "storageContainerName": "data",
    "uniqueStorageName": "[concat(parameters('storageAccountName'), uniqueString(resourceGroup().id))]"
  }
}
```