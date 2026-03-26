// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 06: Network Traffic Management (Load Balancer)

param location string = 'eastus'
param lbName string = 'LB-DRTC-PROD'

// 1. Public IP for the Load Balancer Frontend
resource lbPip 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'PIP-LB-DRTC-WEST'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

// 2. The Load Balancer Resource
resource loadBalancer 'Microsoft.Network/loadBalancers@2023-05-01' = {
  name: lbName
  location: location
  sku: { name: 'Standard' }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LB-Frontend-Config'
        properties: {
          publicIPAddress: { id: lbPip.id }
        }
      }
    ]
    // Backend pool where our future VMs will live
    backendAddressPools: [
      {
        name: 'LB-Backend-Pool'
      }
    ]
    // Health Probe: Checks if port 80 is responding
    probes: [
      {
        name: 'HTTP-Health-Probe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 15
          numberOfProbes: 2
        }
      }
    ]
    // LB Rule: Forwards Port 80 traffic from Frontend to Backend
    loadBalancingRules: [
      {
        name: 'HTTP-Traffic-Rule'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', lbName, 'LB-Frontend-Config')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', lbName, 'LB-Backend-Pool')
          }
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', lbName, 'HTTP-Health-Probe')
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
          idleTimeoutInMinutes: 4
          loadDistribution: 'Default'
        }
      }
    ]
  }
}