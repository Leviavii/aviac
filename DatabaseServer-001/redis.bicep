@description('Redis module for DatabaseServer-001 - INTENTIONALLY ENABLES public network access')

param redisName string
param location string  
param enablePublicAccess bool

// Create Redis Cache with INTENTIONALLY ENABLED public network access
resource redisCache 'Microsoft.Cache/redis@2023-08-01' = {
  name: redisName
  location: location
  properties: {
    sku: {
      name: 'Basic'
      family: 'C'
      capacity: 0
    }
    // INTENTIONAL FAILURE: Setting publicNetworkAccess to 'Enabled' instead of 'Disabled'
    publicNetworkAccess: enablePublicAccess ? 'Enabled' : 'Disabled'
    
    // Additional properties
    minimumTlsVersion: '1.2'
    redisConfiguration: {
      'maxclients': '256'
    }
  }
}

output redisName string = redisCache.name
output redisId string = redisCache.id
output publicNetworkAccessStatus string = redisCache.properties.publicNetworkAccess
