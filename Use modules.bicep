@description('Name of the app service plan')
param appServiceAppName string

@description('the type of environment')
@allowed([
  'development'
  'production'
])
param environmentTpye string = 'production'
param location string = resourceGroup().location

module storageaccount '001 storageAccount.bicep' = {
  name: 'storageaccountdeployment'
}

module appModule '01b app.bicep' = {
  name: 'myApp'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentTpye
  }
}
