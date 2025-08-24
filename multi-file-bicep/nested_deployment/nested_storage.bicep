// Nested storage module - common result of ARM template conversion
param location string
param environmentType string  
param storagePrefix string

var storageAccountName = '${storagePrefix}${environmentType}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: take(storageAccountName, 24)
  location: location
  sku: {
    name: environmentType == 'prod' ? 'Standard_GRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
