@description('Main deployment for StorageAccount-013 rule testing - intentionally FAILS blob container public access check')

param location string = resourceGroup().location
param storageAccountName string = 'st${uniqueString(resourceGroup().id)}test'
param containerName string = 'public-container'
param containerPublicAccess string = 'Container'  // This will cause the failure!

// Deploy Storage Account
module storageModule 'storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

// Deploy Container module - This will intentionally set public access to 'Container'
module containerModule 'container.bicep' = {
  name: 'containerDeployment'
  params: {
    storageAccountName: storageAccountName
    containerName: containerName
    publicAccess: containerPublicAccess
  }
  dependsOn: [
    storageModule
  ]
}

output storageAccountName string = storageModule.outputs.storageAccountName
output containerName string = containerModule.outputs.containerName
output expectedFailureReason string = 'INTENTIONAL FAILURE: Blob container deployed with publicAccess=Container - will trigger StorageAccount-013 rego rule'
