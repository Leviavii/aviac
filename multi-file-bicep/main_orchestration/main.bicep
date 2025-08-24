// Main deployment file that orchestrates multiple modules
param environmentName string = 'dev'
param location string = resourceGroup().location
param appName string = 'myapp'

// Call storage module
module storageModule 'storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: '${appName}${environmentName}storage'
    location: location
    environmentName: environmentName
  }
}

// Call networking module  
module networkModule 'networking.bicep' = {
  name: 'networkDeployment'
  params: {
    vnetName: '${appName}-${environmentName}-vnet'
    location: location
    environmentName: environmentName
  }
}

// Call application module with dependencies
module appModule 'application.bicep' = {
  name: 'applicationDeployment'
  params: {
    appName: appName
    location: location
    environmentName: environmentName
    storageAccountName: storageModule.outputs.storageAccountName
    subnetId: networkModule.outputs.appSubnetId
  }
  dependsOn: [
    storageModule
    networkModule
  ]
}

// Call RBAC module for security
module rbacModule 'rbac.bicep' = {
  name: 'rbacDeployment'
  params: {
    principalId: appModule.outputs.managedIdentityPrincipalId
    storageAccountName: storageModule.outputs.storageAccountName
    environmentName: environmentName
  }
  dependsOn: [
    appModule
    storageModule
  ]
}

// Outputs from main deployment
output storageAccountName string = storageModule.outputs.storageAccountName
output appServiceName string = appModule.outputs.appServiceName
output vnetName string = networkModule.outputs.vnetName
