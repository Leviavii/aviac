// Networking module - created from ARM templates with complex networking resources
param vnetName string
param location string
param environmentName string

var addressPrefix = environmentName == 'prod' ? '10.1.0.0/16' : '10.0.0.0/16'
var appSubnetPrefix = environmentName == 'prod' ? '10.1.1.0/24' : '10.0.1.0/24'
var dbSubnetPrefix = environmentName == 'prod' ? '10.1.2.0/24' : '10.0.2.0/24'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: '${vnetName}-app-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHTTPS'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowHTTP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1001
          direction: 'Inbound'
        }
      }
    ]
  }
  tags: {
    Environment: environmentName
    Purpose: 'Application Security'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'app-subnet'
        properties: {
          addressPrefix: appSubnetPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
            {
              service: 'Microsoft.KeyVault'
            }
          ]
        }
      }
      {
        name: 'db-subnet'
        properties: {
          addressPrefix: dbSubnetPrefix
          delegations: [
            {
              name: 'Microsoft.DBforMySQL/flexibleServers'
              properties: {
                serviceName: 'Microsoft.DBforMySQL/flexibleServers'
              }
            }
          ]
        }
      }
    ]
  }
  tags: {
    Environment: environmentName
    Purpose: 'Application Networking'
  }
}

output vnetName string = virtualNetwork.name
output vnetId string = virtualNetwork.id
output appSubnetId string = '${virtualNetwork.id}/subnets/app-subnet'
output dbSubnetId string = '${virtualNetwork.id}/subnets/db-subnet'
