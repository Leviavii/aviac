param vmName string = 'myVM'

@allowed([
  'Standard_B1s'
  'Standard_B2s'
  'Standard_D2s_v3'
])
param vmSize string = 'Standard_B2s'

param adminUsername string = 'azureuser'

@secure()
param adminPassword string

param location string = resourceGroup().location

var vnetName = '${vmName}-vnet'
var subnetName = 'default'
var nicName = '${vmName}-nic'
var publicIPName = '${vmName}-ip'
var nsgName = '${vmName}-nsg'
var vnetAddressPrefix = '10.0.0.0/16'
var subnetAddressPrefix = '10.0.0.0/24'
var vmSizeMapping = {
  'Standard_B1s': {
    cores: 1
    memory: '1 GB'
    premium: false
  }
  'Standard_B2s': {
    cores: 2
    memory: '4 GB'
    premium: false
  }
  'Standard_D2s_v3': {
    cores: 2
    memory: '8 GB'
    premium: true
  }
}
var selectedVmConfig = vmSizeMapping[vmSize]
var storageAccountType = selectedVmConfig.premium ? 'Premium_LRS' : 'Standard_LRS'
var vmTags = {
  VMSize: vmSize
  Cores: string(selectedVmConfig.cores)
  Memory: selectedVmConfig.memory
  PremiumStorage: string(selectedVmConfig.premium)
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIPName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1001
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
          subnet: {
            id: '${virtualNetwork.id}/subnets/${subnetName}'
          }
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  tags: vmTags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: storageAccountType
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}

output vmName string = virtualMachine.name
output publicIPAddress string = publicIP.properties.ipAddress
output vmConfiguration object = selectedVmConfig
output networkDetails object = {
  virtualNetwork: vnetName
  subnet: subnetName
  vnetAddressSpace: vnetAddressPrefix
  subnetAddressSpace: subnetAddressPrefix
}
