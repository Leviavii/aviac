param webAppName string = 'mywebapp001'
param appServicePlanName string = 'myappplan001'
param location string = resourceGroup().location

@allowed(['dev', 'staging', 'prod'])
param environmentType string = 'dev'

var appServicePlanSku = environmentType == 'prod' ? 'S2' : 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
  }
  kind: 'app'
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
