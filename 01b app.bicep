param appServiceAppName string
param environmentType string
param location string = resourceGroup().location

var tags = {
  environmentType: environmentType
}


resource webApplication 'Microsoft.Web/sites@2023-01-01' = {
  name: '${appServiceAppName}-app'
  location: location
  tags: tags
  properties: {
    serverFarmId: webServerFarm.id
  }
}

resource webServerFarm 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServiceAppName
  tags: tags
  location: location
  kind: 'linux'
  sku: {
    name: 'F1'
  }
}
