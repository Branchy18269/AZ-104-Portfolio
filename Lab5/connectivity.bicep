// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 05: Intersite Connectivity (Bastion & VPN Gateway)

param location string = 'eastus'
param vnetName string = 'VNET-DRTC-EAST'

// 1. Create the specialized 'GatewaySubnet' (Required for VPN)
resource gatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${vnetName}/GatewaySubnet'
  properties: {
    addressPrefix: '10.1.255.0/27'
  }
}

// 2. Create the specialized 'AzureBastionSubnet' (Required for Bastion)
resource bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${vnetName}/AzureBastionSubnet'
  properties: {
    addressPrefix: '10.1.254.0/26'
  }
}

// 3. Public IP for Bastion
resource bastionPip 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'PIP-BST-DRTC'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

// 4. Azure Bastion Host
resource bastionHost 'Microsoft.Network/bastionHosts@2023-05-01' = {
  name: 'BST-DRTC-PROD'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'bastionIpConf'
        properties: {
          subnet: { id: bastionSubnet.id }
          publicIPAddress: { id: bastionPip.id }
        }
      }
    ]
  }
}

// 5. Public IP for VPN Gateway
resource vpnPip 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'PIP-VGW-DRTC'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

// 6. Virtual Network Gateway (VPN)
resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2023-05-01' = {
  name: 'VGW-DRTC-PROD'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'vnetGatewayConfig'
        properties: {
          publicIPAddress: { id: vpnPip.id }
          subnet: { id: gatewaySubnet.id }
        }
      }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    sku: { name: 'VpnGw1', tier: 'VpnGw1' }
  }
}