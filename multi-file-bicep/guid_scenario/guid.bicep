// GUID-based deployment - commonly generated from ARM templates with GUID functions
param deploymentName string = 'guid-deployment'
param location string = resourceGroup().location
param resourceTags object = {}

// Generate consistent GUIDs for deployment
var deploymentGuid = guid(resourceGroup().id, deploymentName)
var roleAssignmentGuid = guid(resourceGroup().id, deploymentName, 'roleAssignment')

// Create a managed identity with GUID-based name
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2021-09-30-preview' = {
  name: 'identity-${take(deploymentGuid, 8)}'
  location: location
  tags: union(resourceTags, {
    DeploymentGuid: deploymentGuid
    CreatedBy: 'GUID-based deployment'
  })
}

// Role assignment with GUID name to avoid conflicts
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleAssignmentGuid
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c') // Contributor
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
    description: 'GUID-based role assignment for deployment ${deploymentName}'
  }
}

// Key Vault with GUID-based access policy
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: 'kv-${take(deploymentGuid, 12)}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: managedIdentity.properties.principalId
        permissions: {
          keys: ['get', 'list']
          secrets: ['get', 'list']
          certificates: ['get', 'list']
        }
      }
    ]
  }
  tags: union(resourceTags, {
    DeploymentGuid: deploymentGuid
    AccessPolicyGuid: guid(managedIdentity.properties.principalId, 'keyVaultAccess')
  })
}

output deploymentGuid string = deploymentGuid
output managedIdentityId string = managedIdentity.id
output keyVaultName string = keyVault.name
output roleAssignmentGuid string = roleAssignmentGuid
