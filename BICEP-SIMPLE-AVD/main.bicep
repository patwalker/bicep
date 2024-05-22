// deployment scope

targetScope = 'subscription'

// deployment parameters

param resourceGroupName string = 'rg'
param resourceGroupLocation string = 'westeurope'

param storageLocation string = 'westeurope'
param storageName string = 'patfslogixstgbicep'
param fslogixFileShareName string = 'fslogix-profiles'
param fslogixFileShareAccessTier string = 'Hot'
param fslogixFileShareQuota int = 100

param networkResourceLocation string = 'westeurope'

param vnetName string = 'vnet-pat-bicep-weu001'
param vnetAddressPrefix string = '10.100.0.0/16'

param avdSubnetName string = 'avdsnet'
param avdSubnetAddressPrefix string = '10.100.100.0/24'

param peSubnetName string = 'storagesnet'
param peSubnetAddressPrefix string = '10.100.101.0/24'

param privateLinkServiceName string = 'privatelinkcore.windows.net'
param privateLinkServiceIPConfiguration string = 'pvt-ipcfg-pat-bicep-weu001'

param privateEndpointName string = 'fspe-pat-bicep-weu001'
param privateEndpointCustomNICName string = 'fspe-pat-bicep-weu001'

param nicPEName string = 'fspe-pat-bicep-nic001'
param nicPEIPConfiguration string = 'fspe-nic-ipconfig'

param privateDnsZoneName string = 'privatelink${environment().suffixes.storage}'
param privateEndpointDnsGroupName string = '${privateEndpointName}/patwalkerbicep'

param avdDesktopHostPoolName string = 'hp-pat-bicep-weu001'
param avdBackplaneResourceLocation string = 'westeurope'
param avdDesktopHostPoolType string = 'pooled'
param avdLoadbalancerType string = 'BreadthFirst'
param avdDesktopHostPoolPreferredAppGroupType string = 'Desktop'
param avdDesktopHostPoolFriendlyName string = 'HP-PAT-BICEP'
param avdDesktopHostPoolPublicNetworkAccess string = 'disabled'
param avdStartVMOnConnect bool = true

param avdDesktopAppGroupName string = 'ag-pat-bicep-desktop-weu001'
param avdDesktopAppShowInFeed bool = true
param avdAppGroupType string = 'Desktop'
param avdDesktopAppGroupFriendlyName string = 'AG-DSKTP-PAT-BICEP'

param avdWorkspaceName string = 'ws-pat-bicep-weu001'
param avdWorkspaceFriendlyName string = 'WS-PAT-BICEP'

// deployment variables

var deployResourceGroups = bool(false)
var deployStorageAccount = bool(false)
var deployVirtualNetwork = bool(false)
var deployAvdBackPlane = bool(true)

// deployment modules

module resourceGroups 'modules/rg-deploy.bicep' = if(deployResourceGroups) {
  name: resourceGroupName
  params: {
    resourceGroupLocation: resourceGroupLocation
  }
}

module fslogixStorageAccount 'modules/storage-module.bicep' = if(deployStorageAccount) {
  scope: resourceGroup('rg-pat-bicep-storage-weu001')
  name: storageName
  params: {
    storageLocation: storageLocation 
    storageName: storageName
    fslogixFileShareAccessTier: fslogixFileShareAccessTier
    fslogixFileShareName: fslogixFileShareName
    fslogixFileShareQuota: fslogixFileShareQuota
    fileSvcPrivateEndpointName: privateEndpointName
    peSubnetName: peSubnetName
    vnetName: vnetName
  }
}

module virtualNetwork 'modules/vnet-module.bicep' = if(deployVirtualNetwork) {
  scope: resourceGroup('rg-pat-bicep-network-weu001')
  name: vnetName
  params: {
    avdSubnetAddressPrefix: avdSubnetAddressPrefix
    avdSubnetName: avdSubnetName
    vnetAddressPrefix: vnetAddressPrefix
    vnetName: vnetName
    
    nicPEIPConfiguration: nicPEIPConfiguration
    nicPEName: nicPEName
    peSubnetAddressPrefix: peSubnetAddressPrefix
    peSubnetName: peSubnetName
    privateEndpointCustomNICName: privateEndpointCustomNICName
    privateEndpointName: privateEndpointName
    privateLinkServiceName: privateLinkServiceName
    networkResourceLocation: networkResourceLocation
    privateLinkServiceIPConfiguration: privateLinkServiceIPConfiguration
    
  }
}

module avdBackPlane 'modules/avd-backplane-module.bicep' = if(deployAvdBackPlane) {
  scope: resourceGroup('rg-pat-bicep-avd-weu001')
  name: avdDesktopHostPoolName
  params: {
    avdAppGroupType: avdAppGroupType
    avdBackplaneResourceLocation: avdBackplaneResourceLocation
    avdDesktopAppGroupFriendlyName: avdDesktopAppGroupFriendlyName
    avdDesktopAppGroupName: avdDesktopAppGroupName
    avdDesktopAppShowInFeed: avdDesktopAppShowInFeed
    avdDesktopHostPoolFriendlyName: avdDesktopHostPoolFriendlyName
    avdDesktopHostPoolName: avdDesktopHostPoolName
    avdDesktopHostPoolPreferredAppGroupType: avdDesktopHostPoolPreferredAppGroupType
    avdDesktopHostPoolPublicNetworkAccess: avdDesktopHostPoolPublicNetworkAccess
    avdDesktopHostPoolType: avdDesktopHostPoolType
    avdLoadbalancerType: avdLoadbalancerType
    avdStartVMOnConnect: avdStartVMOnConnect
    avdWorkspaceFriendlyName: avdWorkspaceFriendlyName
    avdWorkspaceName: avdWorkspaceName
  }
}
