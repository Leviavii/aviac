param keyVaultName string = 'kv-${uniqueString(resourceGroup().id)}'

@secure()
param secretValue string = 'MySecretPassword123!'

param configData string = '{"environment":"production","debug":false}'
param location string = resourceGroup().location

var tenantId = subscription().tenantId
var subscriptionId = subscription().subscriptionId
var deploymentName = deployment().name
var resourceGroupId = resourceGroup().id
var uniqueGuid = guid(resourceGroup().id, deployment().name)
var encodedSecret = base64(secretValue)
var configObject = json(configData)
var encodedConfig = base64(configData)
var decodedConfig = base64ToJson(encodedConfig)
var keyVaultUri = 'https://${keyVaultName}.vault.azure.net/'
var resourceTags = {
  DeploymentId: uniqueGuid
  DeploymentName: deploymentName
  SubscriptionId: subscriptionId
  TenantId: tenantId
  CreatedBy: 'ARM Template'
  Environment: configObject.environment
  Debug: string(configObject.debug)
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  tags: resourceTags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enabledForDeployment: false
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
  }
}

resource secretResource 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  parent: keyVault
  name: 'mysecret'
  properties: {
    value: secretValue
    attributes: {
      enabled: true
    }
  }
}

resource configSecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  parent: keyVault
  name: 'config'
  properties: {
    value: encodedConfig
    contentType: 'application/json'
    attributes: {
      enabled: true
    }
  }
}

output keyVaultName string = keyVault.name
output keyVaultUri string = keyVaultUri
output deploymentGuid string = uniqueGuid
output tenantId string = tenantId
output subscriptionInfo object = {
  subscriptionId: subscriptionId
  resourceGroupName: resourceGroup().name
  resourceGroupLocation: resourceGroup().location
}
output configurationData object = decodedConfig
output hasProductionConfig bool = configObject.environment == 'production'
