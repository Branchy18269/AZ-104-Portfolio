#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 10: Monitoring
# Description: Deploying Log Analytics and CPU Alerts
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="monitoring.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 10: Infrastructure Monitoring"
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning Log Analytics Workspace and Action Groups..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab10-Monitoring"

# Retrieve the Workspace ID for Diagnostic Settings
WORKSPACE_ID=$(az monitor log-analytics workspace show -g "$RG_NAME" -n "LAW-DRTC-PROD" --query id -o tsv)

echo "[DIAGNOSTICS] Linking VMs to Log Analytics..."
# Enabling diagnostic settings for the web servers
vms=("VM-WEB-01" "VM-WEB-02")
for vm in "${vms[@]}"; do
    echo "Configuring diagnostics for $vm..."
    az monitor diagnostic-settings create \
        --name "Diag-to-LAW" \
        --resource "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RG_NAME/providers/Microsoft.Compute/virtualMachines/$vm" \
        --workspace "$WORKSPACE_ID" \
        --metrics '[{"category": "AllMetrics", "enabled": true}]'
done

echo "------------------------------------------------------------"
echo "LAB 10 COMPLETE"
echo "Workspace: LAW-DRTC-PROD"
echo "Alerts Active: High CPU (>80%)"
echo "Notification Target: WillH@drtc.net"
echo "------------------------------------------------------------"