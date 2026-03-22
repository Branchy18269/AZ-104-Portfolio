// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 08: Azure Virtual Machines (Windows Server 2022)

param location string = 'eastus'
param adminUsername string = 'drtcadmin'
@secure()
param adminPassword string
param vnetName string = 'VNET-DRTC-EAST'
param subnetName string = 'Subnet-Core'
param lbName string = 'LB-DRTC-PROD'

// 1. Availability Set (Ensures VMs are on different physical hardware)
resource availabilitySet 'Microsoft.Compute/availabilitySets@2023-09-01' = {
  name: 'AS-DRTC-WEB'
  location: location
  sku: { name: 'Aligned' }
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 2
  }
}

// 2. Network Interfaces (NICs) - Looping to create 2
resource nics 'Microsoft.Network/networkInterfaces@2023-05-01' = [for i in range(0, 2): {
  name: 'NIC-WEB-0${i + 1}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName) }
          privateIPAllocationMethod: 'Dynamic'
          // Connecting to the Load Balancer Backend Pool from Lab 06
          loadBalancerBackendAddressPools: [
            { id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', lbName, 'LB-Backend-Pool') }
          ]
        }
      }
    ]
  }
}]

// 3. Virtual Machines - Looping to create 2
resource vms 'Microsoft.Compute/virtualMachines@2023-09-01' = [for i in range(0, 2): {
  name: 'VM-WEB-0${i + 1}'
  location: location
  properties: {
    availabilitySet: { id: availabilitySet.id }
    hardwareProfile: { vmSize: 'Standard_B2s' } // Matches the Policy from Lab 02
    osProfile: {
      computerName: 'VM-WEB-0${i + 1}'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: { createOption: 'FromImage', managedDisk: { storageAccountType: 'Standard_LRS' } }
    }
    networkProfile: {
      networkInterfaces: [ { id: nics[i].id } ]
    }
  }
}]

// 4. Custom Script Extension: Install IIS
resource installIIS 'Microsoft.Compute/virtualMachines/extensions@2023-09-01' = [for i in range(0, 2): {
  parent: vms[i]
  name: 'InstallIIS'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'powershell Add-WindowsFeature Web-Server; powershell Set-Content -Path "C:\\inetpub\\wwwroot\\iisstart.htm" -Value "Response from DRTC Server: $($env:computername)"'
    }
  }
}]