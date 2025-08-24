param storageAccountCount int = 3
@minValue(1)
@maxValue(5)
param baseStorageSize int = 100
param multiplier int = 2
param location string = resourceGroup().location

var storageAccountPrefix = 'storage'
var maxStorageSize = baseStorageSize * multiplier
var totalCost = maxStorageSize + (storageAccountCount / 2)
var discountThreshold = maxStorageSize - 50
var storageSkuBasedOnCount = storageAccountCount > 2 ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccounts 'Microsoft.Storage/storageAccounts@2021-04-01' = [for i in range(0, storageAccountCount): {
  name: '${storageAccountPrefix}${i + 1}${uniqueString(resourceGroup().id, string(i))}'
  location: location
  sku: {
    name: storageSkuBasedOnCount
  }
  kind: 'StorageV2'
  properties: {
    accessTier: i % 2 == 0 ? 'Hot' : 'Cool'
  }
  tags: {
    Index: string(i)
    StorageNumber: string(i + 1)
    CalculatedSize: string(maxStorageSize + (i * 10))
    IsEven: string(i % 2 == 0)
  }
}]

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = if (storageAccountCount > 1) {
  parent: storageAccounts[0]
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7 + (storageAccountCount * 3)
    }
  }
}

output createdStorageCount int = storageAccountCount
output maxStorageSize int = maxStorageSize
output totalCalculatedCost int = totalCost
output discountApplies bool = totalCost > discountThreshold
output storageAccountNames array = [for i in range(0, storageAccountCount): '${storageAccountPrefix}${i + 1}${uniqueString(resourceGroup().id, string(i))}']
