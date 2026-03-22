// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 09: Data Protection (Recovery Services Vault & Policy)

param location string = 'eastus'
param vaultName string = 'RSV-DRTC-PROD'

// 1. Recovery Services Vault
resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: vaultName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

// 2. Backup Policy (Daily at 11:00 PM, 30-day retention)
resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-01-01' = {
  parent: recoveryServicesVault
  name: 'Policy-Daily-VM'
  properties: {
    backupManagementType: 'AzureIaasVM'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-03-22T23:00:00Z'
      ]
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-03-22T23:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    timeZone: 'UTC'
  }
}

output vaultId string = recoveryServicesVault.id
output policyId string = backupPolicy.id