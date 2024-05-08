

@minLength(3)
@maxLength(19)
param stgActNamePrefix string


@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
])
param stgActSKU string = 'Standard_LRS'


param stgTags object = {
  Environment: 'DEMO'
  Dept: 'IT'
}

param location string = resourceGroup().location

var uniqueID = uniqueString(resourceGroup().id, deployment().name)
var uniqueIDShort = take(uniqueID,5)
var stgActName = '${stgActNamePrefix}${uniqueIDShort}'
//var storageName = '${stgActNamePrefix}${take (uniqueString(resourceGroup().id, deployment().name), 5)}'
//var location = resourceGroup().location

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: stgActName
  sku: {
    name: stgActSKU
  }
  kind: 'StorageV2'
  location: location
  tags: stgTags
}
