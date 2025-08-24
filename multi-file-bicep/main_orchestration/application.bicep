// Application module - often created from ARM templates with nested app resources
param appName string
param location string
param environmentName string
param storageAccountName string
param subnetId string

var appServicePlanName = '${appName}-${environmentName}-plan'
var appServiceName = '${appName}-${environmentName}-app'
var appInsightsName = '${appName}-${environmentName}-insights'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: environmentName == 'prod' ? 'P1v3' : 'B1'
    tier: environmentName == 'prod' ? 'PremiumV3' : 'Basic'
  }
  kind: 'app'
  properties: {
    reserved: false
  }
  tags: {
    Environment: environmentName
    Application: appName
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2021-09-30-preview' = {
  name: '${appServiceName}-identity'
  location: location
  tags: {
    Environment: environmentName
    Application: appName
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
  tags: {
    Environment: environmentName
    Application: appName
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlan.id
    virtualNetworkSubnetId: subnetId
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'ENVIRONMENT'
          value: environmentName
        }
        {
          name: 'STORAGE_ACCOUNT_NAME'
          value: storageAccountName
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultStorage'
          connectionString: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=core.windows.net'
          type: 'Custom'
        }
      ]
    }
  }
  tags: {
    Environment: environmentName
    Application: appName
  }
}

output appServiceName string = appService.name
output appServiceId string = appService.id
output managedIdentityPrincipalId string = managedIdentity.properties.principalId
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
