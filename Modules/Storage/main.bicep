
param location string = 'eastus2'
param storageAccountName string = 'standres001secureapp'
param keyvaultname string= 'keyvalue1'

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
 resource keyVault 'Microsoft.KeyVault/vaults@2026-05-15' =  {
  name: keyvaultname
  location: location
  properties: {
    tenantId: tenant().tenantId
    sku: {
      family: 'A'
      name: 'standard'
  }
 }
}

