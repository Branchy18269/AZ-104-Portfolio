// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 07: Azure Storage (Secure File Shares & Networking)

param location string = 'eastus'
param storageAccountName string = 'staz104adv${uniqueString(resourceGroup().id)}'
param vnetName string = 'VNET-DRTC-EAST'

// 1. Storage Account with Network Security Rules
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    // Network ACLs: Restricting access to the DRTC Virtual Network
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny' // Block everything by default
      virtualNetworkRules: [
        {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'Subnet-Core')
          action: 'Allow'
        }
      ]
    }
  }
}

// 2. File Service and a specific File Share for DRTC Backups
resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = {
  parent: fileServices
  name: 'drtc-backups'
  properties: {
    shareQuota: 100 // 100 GB Quota
  }
}

output storageName string = storageAccount.name