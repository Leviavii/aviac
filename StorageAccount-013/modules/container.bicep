@description('Container module for StorageAccount-013 - INTENTIONALLY ENABLES public access')

param storageAccountName string
param containerName string
param publicAccess string

// Reference the existing storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

// Reference the blob service  
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' existing = {
  name: 'default'
  parent: storageAccount
}

// Create container with INTENTIONALLY ENABLED public access
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: containerName
  parent: blobService
  properties: {
    // INTENTIONAL FAILURE: Setting publicAccess to 'Container' instead of 'None'
    publicAccess: publicAccess  // Will be 'Container' which triggers the rego rule
    metadata: {
      purpose: 'rego-rule-testing'
      rule: 'StorageAccount-013'
    }
  }
}

output containerName string = container.name
output containerPublicAccess string = container.properties.publicAccess
