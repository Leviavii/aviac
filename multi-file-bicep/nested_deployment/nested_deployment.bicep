// Nested deployment - created when ARM templates have nested deployment resources
param parentDeploymentName string = 'parent-deployment'
param location string = resourceGroup().location
param environmentType string = 'dev'

// Child deployment for storage resources
module storageDeployment 'nested_storage.bicep' = {
  name: '${parentDeploymentName}-storage-nested'
  params: {
    location: location
    environmentType: environmentType
    storagePrefix: 'nested'
  }
}

// Child deployment for compute resources  
module computeDeployment 'nested_compute.bicep' = {
  name: '${parentDeploymentName}-compute-nested'
  params: {
    location: location
    environmentType: environmentType
    storageAccountName: storageDeployment.outputs.storageAccountName
  }
  dependsOn: [
    storageDeployment
  ]
}

// Nested RBAC deployment - common pattern in converted ARM templates
module rbacDeployment 'nested_rbac.bicep' = {
  name: '${parentDeploymentName}-rbac-nested'
  params: {
    principalId: computeDeployment.outputs.principalId
    storageAccountName: storageDeployment.outputs.storageAccountName
    environmentType: environmentType
  }
  dependsOn: [
    storageDeployment
    computeDeployment
  ]
}

output storageAccountName string = storageDeployment.outputs.storageAccountName
output computeResourceName string = computeDeployment.outputs.computeResourceName
output roleAssignmentId string = rbacDeployment.outputs.roleAssignmentId
