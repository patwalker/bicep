targetScope = 'resourceGroup'

param storageLocation string
param storageName string

param fslogixFileShareName string
param fslogixFileShareAccessTier string
param fslogixFileShareQuota int

param vnetName string
param peSubnetName string

param fileSvcPrivateEndpointName string

resource fslogixStorageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: storageLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {}
}

resource fslogixFileService 'Microsoft.Storage/storageAccounts/fileServices@2023-04-01' = {
  name: 'default'
  parent: fslogixStorageAccount
  properties: {}
}

resource fslogixFileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-04-01' = {
  name: fslogixFileShareName
  parent: fslogixFileService
  properties: {
    accessTier: fslogixFileShareAccessTier
    enabledProtocols: 'SMB'
    shareQuota: fslogixFileShareQuota
  }
}
/*
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' existing = {
  name: peSubnetName
  parent: virtualNetwork
}

resource fileSvcPrivateEndpoint 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-04-01' = {
  name: fileSvcPrivateEndpointName
  parent: fslogixStorageAccount
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
    }
  }
} 
*/
