@description('Web App module for AppService-010 - INTENTIONALLY MISSING authsettings config')

param webAppName string
param location string
param appServicePlanId string

// Create Web App WITHOUT authsettings config
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '18.x'
        }
      ]
      linuxFxVersion: ''
      alwaysOn: false
      minTlsVersion: '1.0'
    }
    httpsOnly: true
  }
}

// INTENTIONALLY OMITTING THIS RESOURCE - This is what will cause the rego rule to fail:
/*
resource authSettings 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'authsettings'
  parent: webApp
  properties: {
    enabled: true
    // ... other auth properties
  }
}
*/

output webAppName string = webApp.name
output webAppId string = webApp.id
