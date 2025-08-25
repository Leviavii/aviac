@description('Main deployment for DatabaseServer-001 rule testing - intentionally FAILS Redis public access check')

param location string = resourceGroup().location
param redisName string = 'redis-test-${uniqueString(resourceGroup().id)}'
param enablePublicAccess bool = true  // This will cause the failure!

// Deploy Redis module - This will intentionally enable public network access
module redisModule 'modules/redis.bicep' = {
  name: 'redisDeployment'
  params: {
    redisName: redisName
    location: location
    enablePublicAccess: enablePublicAccess
  }
}

output redisName string = redisModule.outputs.redisName
output expectedFailureReason string = 'INTENTIONAL FAILURE: Redis deployed with publicNetworkAccess=Enabled - will trigger DatabaseServer-001 rego rule'
