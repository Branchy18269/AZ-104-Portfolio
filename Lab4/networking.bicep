// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 04: Virtual Networking & Global Peering

param location1 string = 'eastus'
param location2 string = 'westus'

// Hub VNet in East US
resource vnetEast 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'VNET-DRTC-EAST'
  location: location1
  properties: {
    addressSpace: { addressPrefixes: ['10.1.0.0/16'] }
    subnets: [
      {
        name: 'Subnet-Core'
        properties: { addressPrefix: '10.1.0.0/24' }
      }
    ]
  }
}

// Spoke VNet in West US
resource vnetWest 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'VNET-DRTC-WEST'
  location: location2
  properties: {
    addressSpace: { addressPrefixes: ['10.2.0.0/16'] }
    subnets: [
      {
        name: 'Subnet-Remote'
        properties: { addressPrefix: '10.2.0.0/24' }
      }
    ]
  }
}

// Peering: East to West
resource peeringEastToWest 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  parent: vnetEast
  name: 'East-To-West'
  properties: {
    remoteVirtualNetwork: { id: vnetWest.id }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

// Peering: West to East (The return path)
resource peeringWestToEast 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  parent: vnetWest
  name: 'West-To-East'
  properties: {
    remoteVirtualNetwork: { id: vnetEast.id }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}