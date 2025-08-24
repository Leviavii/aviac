param storageAccountName string
param location string = resourceGroup().location

var uniqueStorageName = '${storageAccountName}${uniqueString(resourceGroup().id)}'
var storageContainerName = 'data'
var resourcePrefix = 'rg-${resourceGroup().name}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storageAccount.name}/default/${storageContainerName}'
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountId string = storageAccount.id
output primaryEndpoint string = storageAccount.properties.primaryEndpoints.blob
output connectionString string = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value}'
