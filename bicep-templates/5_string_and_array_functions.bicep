param applicationName string = 'MyApp-Production-v1.0'
param tagsList array = ['Environment:Prod', 'Team:DevOps', 'Project:WebApp']
param location string = resourceGroup().location
param currentDate string = utcNow('yyyy-MM-dd')

var appNameParts = split(applicationName, '-')
var cleanAppName = replace(toLower(appNameParts[0]), ' ', '')
var versionNumber = substring(appNameParts[2], 1, length(appNameParts[2]))
var storageNameBase = '${cleanAppName}storage'
var storageAccountName = take('${storageNameBase}${uniqueString(resourceGroup().id)}', 24)
var tagsObject = {
  Application: cleanAppName
  Version: versionNumber
  CreatedDate: currentDate
  ResourceCount: string(length(appNameParts))
}
var combinedTags = union(tagsObject, {
  Environment: contains(applicationName, 'Prod') ? 'Production' : 'Development'
})
var hasMultipleParts = length(appNameParts) > 2

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  tags: combinedTags
  sku: {
    name: hasMultipleParts ? 'Standard_GRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output parsedAppName string = cleanAppName
output appNameLength int = length(cleanAppName)
output versionInfo string = versionNumber
output isProduction bool = contains(applicationName, 'Prod')
output combinedTags object = combinedTags
