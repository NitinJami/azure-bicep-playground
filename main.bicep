// =========== main.bicep ===========
// az deployment sub create --location <location> --template-file <path-to-bicep>

@description('Specifies the location for resources. Passed via "--location" argument of az create command.')
param location string = deployment().location

targetScope = 'subscription' //RG should be created at subscription scope.

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-csgoserver-${location}'
  location: location
}

// RG created. Now create resources under this RG.
// For this project, we need -- 
// a.) VM and it's dependencies. 
// b.) Storage Account -- Queue
// c.) Function App

module stg './storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'stcsgoserver'
    location: location
  }
  scope: rg
}
