@minLength(3)
@maxLength(11)
param storageName string

resource storageacc7 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'bicepdev'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}


output storageEndpoint object = storageacc7.properties.primaryEndpoints


//8 

