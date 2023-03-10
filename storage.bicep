// =========== storage.bicep ===========

// targetScope = 'resourceGroup' - not needed since it is the default value

param storageAccountName string
param location string

resource stg 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name:'Standard_LRS'
  }
  kind: 'StorageV2'
}
