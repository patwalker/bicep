@description('The region to deploy the resources')
param location string = resourceGroup().location
param staPrefix string = 'patwlkr'

var staName = '${staPrefix}${uniqueString(resourceGroup().id)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: staName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
