targetScope = 'resourceGroup'

param networkResourceLocation string

param vnetName string
param vnetAddressPrefix string

param avdSubnetName string
param avdSubnetAddressPrefix string

param peSubnetName string
param peSubnetAddressPrefix string

param privateLinkServiceName string
param privateLinkServiceIPConfiguration string

param privateEndpointName string
param privateEndpointCustomNICName string

param nicPEName string
param nicPEIPConfiguration string

param privateDnsZoneName string = 'privatelink${environment().suffixes.storage}'
param privateEndpointDnsGroupName string = '${privateEndpointName}/patwalkerbicep'


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: networkResourceLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
}

resource avdSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: avdSubnetName
  parent: virtualNetwork
  properties: {
    addressPrefix: avdSubnetAddressPrefix
  }
}

resource peSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = {
  name: peSubnetName
  parent: virtualNetwork
  properties: {
    addressPrefix: peSubnetAddressPrefix
  }
}

/* resource privateLinkService 'Microsoft.Network/privateLinkServices@2023-11-01' = {
  name: privateLinkServiceName
  location: networkResourceLocation
  properties: {
    ipConfigurations: [
      {
        id: peSubnet.id
        name: privateLinkServiceIPConfiguration
        properties: {
          primary: true
          privateIPAddress: '10.100.101.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Static'
          subnet: {
            id: peSubnet.id
            name: peSubnetName
          }
        }
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: nicPEName
  location: networkResourceLocation
  properties: {
    ipConfigurations: [
      {
        name: nicPEIPConfiguration
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: peSubnet.id
          }
        }
      }
    ]
    privateLinkService: {
      id: privateLinkService.id
    }
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2022-01-01' = {
  name: privateEndpointName
  location: networkResourceLocation
  properties: {
    customNetworkInterfaceName: privateEndpointCustomNICName
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, peSubnetName)
    }
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: 'global'
  properties: {}
  dependsOn: [
    virtualNetwork
  ]
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${privateDnsZoneName}-link'
  parent: privateDnsZone
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource privateEndpointDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-11-01' = {
  name: privateEndpointDnsGroupName
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZone.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoint
  ]
}

*/
