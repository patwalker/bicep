targetScope = 'resourceGroup'

param avdDesktopHostPoolName string
param avdBackplaneResourceLocation string
param avdDesktopHostPoolType string
param avdLoadbalancerType string
param avdDesktopHostPoolPreferredAppGroupType string
param avdDesktopHostPoolFriendlyName string
param avdDesktopHostPoolPublicNetworkAccess string
param avdStartVMOnConnect bool

param avdDesktopAppGroupName string
param avdDesktopAppShowInFeed bool
param avdAppGroupType string
param avdDesktopAppGroupFriendlyName string

param avdWorkspaceName string
param avdWorkspaceFriendlyName string

resource avdDesktopHostPool 'Microsoft.DesktopVirtualization/hostPools@2023-09-05' = {
  name: avdDesktopHostPoolName
  location: avdBackplaneResourceLocation
  properties: {
    hostPoolType: avdDesktopHostPoolType
    loadBalancerType: avdLoadbalancerType
    preferredAppGroupType: avdDesktopHostPoolPreferredAppGroupType
    friendlyName: avdDesktopHostPoolFriendlyName
    publicNetworkAccess: avdDesktopHostPoolPublicNetworkAccess
    startVMOnConnect: avdStartVMOnConnect
  }
}

resource avdDesktopAppGroup 'Microsoft.DesktopVirtualization/applicationGroups@2023-09-05' = {
  name: avdDesktopAppGroupName
  location: avdBackplaneResourceLocation
  properties: {
    applicationGroupType: avdAppGroupType
    hostPoolArmPath: avdDesktopHostPool.id
    friendlyName: avdDesktopAppGroupFriendlyName
    showInFeed: avdDesktopAppShowInFeed
  }
}

resource avdWorkspace 'Microsoft.DesktopVirtualization/workspaces@2023-09-05' = {
  name: avdWorkspaceName
  location: avdBackplaneResourceLocation
  properties: {
    applicationGroupReferences: [
      avdDesktopAppGroup.id
    ]
    friendlyName: avdWorkspaceFriendlyName
  }
}
