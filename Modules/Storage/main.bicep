
param location string = 'eastus2'
param storageAccountName string = 'standres001secureapp'

resource storageAccount 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}



