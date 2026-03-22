// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 03: Infrastructure as Code with Bicep

param location string = resourceGroup().location
param storageAccountName string = 'staz104${uniqueString(resourceGroup().id)}'
param vnetName string = 'VNET-AZ104-PROD'

// Resource 1: Storage Account for DRTC Backups
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Resource 2: Virtual Network for Lab Infrastructure
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-Web'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'Subnet-App'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

// Outputs to be used by the deployment script
output storageName string = storageAccount.name
output vnetId string = virtualNetwork.id