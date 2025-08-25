using './main.bicep'

// Parameters for DatabaseServer-001 rule testing
param location = 'East US'
param redisName = 'redis-dbserver001-test'
param enablePublicAccess = true  // This will trigger the rego rule failure!
