@description('Main deployment for AppService-010 rule testing - intentionally FAILS authentication check')

param location string = resourceGroup().location
param appServicePlanName string = 'asp-test-${uniqueString(resourceGroup().id)}'
param webAppName string = 'webapp-test-${uniqueString(resourceGroup().id)}'

// Deploy App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: false
  }
}

// Deploy Web App module - This will intentionally NOT include authsettings
module webAppModule 'webapp.bicep' = {
  name: 'webAppDeployment'
  params: {
    webAppName: webAppName
    location: location
    appServicePlanId: appServicePlan.id
  }
}

output webAppName string = webAppModule.outputs.webAppName
output expectedFailureReason string = 'INTENTIONAL FAILURE: Web App deployed without authsettings config - will trigger AppService-010 rego rule'
