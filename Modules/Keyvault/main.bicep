
param keyvaultname string = 'keyvault01'
param location string = 'eastus2'


 resource keyVault 'Microsoft.KeyVault/vaults@2026-02-01' = {
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
