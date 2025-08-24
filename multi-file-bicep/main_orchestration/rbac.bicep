// RBAC module - typically generated from ARM templates with role assignments
param principalId string
param storageAccountName string
param environmentName string

// Built-in role definitions
var storageBlobDataContributorRoleId = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
var storageBlobDataReaderRoleId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

// Reference to existing storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

// Role assignment for app to access storage
resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(storageAccount.id, principalId, storageBlobDataContributorRoleId)
  scope: storageAccount
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', storageBlobDataContributorRoleId)
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: 'Allow ${environmentName} application to access storage data'
  }
}

// Additional read-only role for monitoring
resource storageReadRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = if (environmentName == 'prod') {
  name: guid(storageAccount.id, principalId, storageBlobDataReaderRoleId, 'monitoring')
  scope: storageAccount
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', storageBlobDataReaderRoleId)
    principalId: principalId
    principalType: 'ServicePrincipal'
    description: 'Additional read access for production monitoring'
  }
}

output storageRoleAssignmentId string = storageRoleAssignment.id
output readRoleAssignmentId string = environmentName == 'prod' ? storageReadRoleAssignment.id : ''
