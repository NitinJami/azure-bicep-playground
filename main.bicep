// =========== main.bicep ===========
// az deployment sub create --location <location> --template-file <path-to-bicep>

targetScope = 'subscription' //RG should be created at subscription scope.

@description('Specifies the location for resources. Passed via "--location" argument of az create command.')
param location string = deployment().location

@description('Name of the server.')
param servername string = 'csgoserver'

@description('Pass in the SSH public key as a parameter from CLI')
param SSHPubKey string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${servername}-${location}'
  location: location
}

// RG created. Now create resources under this RG.
// For this project, we need -- 
// a.) VM and it's dependencies. 
// b.) Storage Account -- Queue
// c.) Function App

module vmnet './vm-network.bicep' = {
  name: 'VM-Netowrk-deployment'
  params: {
    servername: servername
    location: location
  }
  scope: rg
}

module vm './vm-linux.bicep' = {
  name: 'VM-Deployment'
  params: {
    servername: servername
    location: location
    adminpublickey: SSHPubKey
    nicID: vmnet.outputs.nicID
  }
  scope: rg
}

module stg './storage.bicep' = {
  name: 'storageDeployment'
  params: {
    storageAccountName: 'stcsgoserver'
    location: location
  }
  scope: rg
}
