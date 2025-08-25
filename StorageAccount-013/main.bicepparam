using './main.bicep'

// Parameters for StorageAccount-013 rule testing
param location = 'East US'
param storageAccountName = 'ststorage013test'  // Will be made unique with hash
param containerName = 'public-test-container'
param containerPublicAccess = 'Container'  // This will trigger the rego rule failure!
