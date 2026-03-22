// Project: Self Guided AZ104 - Using Done Right Tech Company Resources
// Lab 10: Monitoring (Log Analytics & Alerts)

param location string = 'eastus'
param workspaceName string = 'LAW-DRTC-PROD'
param actionGroupName string = 'AG-DRTC-IT'
param emailAddress string = 'WillH@drtc.net' // Defaulting to your custom username

// 1. Log Analytics Workspace: The central hub for all logs and metrics
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

// 2. Action Group: Who to notify when things go wrong
resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: actionGroupName
  location: 'Global'
  properties: {
    groupShortName: 'DRTC-IT'
    enabled: true
    emailReceivers: [
      {
        name: 'Will Hyndman'
        emailAddress: emailAddress
        useCommonAlertSchema: true
      }
    ]
  }
}

// 3. Metric Alert: Triggers if CPU usage > 80% on VM-WEB-01
// Note: In a production Bicep file, you would loop this for all VMs.
resource cpuAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'Alert-High-CPU-Web01'
  location: 'global'
  properties: {
    description: 'Alert when VM-WEB-01 CPU usage exceeds 80%'
    severity: 2
    enabled: true
    scopes: [
      resourceId('Microsoft.Compute/virtualMachines', 'VM-WEB-01')
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighCPU'
          metricName: 'Percentage CPU'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}