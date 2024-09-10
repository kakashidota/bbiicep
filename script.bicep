

//1 Deployment script ******************************************
//az group create --name PotatoRG
//az group deployment create --resource-group PotatoRG --template-file ./script.bicep --mode Complete
//az group delete --resource-group PotatoRG --yes


//2 ***************
resource storageacc2 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'StorageAcc'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}


//3 **************
var prefix = 'prod'
var storageName = 'Storagepotato'
var storageNamePrefix = '${prefix}-storage'

resource storageacc3 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}


//4 ************
var regions = [
  'westeurope'
  'northeurope'
]

resource storageacc4 'Microsoft.Storage/storageAccounts@2023-05-01' = [for (region, i) in regions: {
  name: '${storageName}${i}'
  location: region
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}]


//5 ****************
resource storageacc5 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: first(regions)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}


//6 **********************
resource storageacc6 'Microsoft.Storage/storageAccounts@2023-05-01' = if (prefix == 'prod') {
  name: 'bicepprod'
  location: first(regions)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}


resource storageacc7 'Microsoft.Storage/storageAccounts@2023-05-01' = if (prefix == 'dev') {
  name: 'bicepdev'
  location: last(regions)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
  }
}



//7.**************
module storageModule 'storage.bicep' = {
  name: 'storageModule'
  params: {
    storageName: 'storagePot'
  }
}
