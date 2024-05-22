targetScope = 'subscription'

param resourceGroupLocation string

var rgName = 'rg-pat-bicep'

resource sharedSVCSRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgName}-shared-svcs-weu001'
  location: resourceGroupLocation
}

resource avdRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgName}-avd-weu001'
  location: resourceGroupLocation
}

resource storageRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgName}-storage-weu001'
  location: resourceGroupLocation
}

resource networkRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${rgName}-network-weu001'
  location: resourceGroupLocation
}
