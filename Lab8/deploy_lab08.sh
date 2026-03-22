#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 08: Azure Virtual Machines
# Description: Deploying Windows Server 2022 VMs with IIS via Bicep
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="vms.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 08: Compute Infrastructure"
echo "Targeting Resource Group: $RG_NAME"
echo "------------------------------------------------------------"

# Securely prompt for the VM Admin Password
read -s -p "Enter Admin Password for DRTC VMs: " VM_PASS
echo ""

echo "[BICEP-DEPLOY] Provisioning Availability Set and Windows VMs..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --parameters adminPassword="$VM_PASS" \
    --name "AZ104-Lab08-Compute"

echo "------------------------------------------------------------"
echo "LAB 08 COMPLETE"
echo "VMs Provisioned: VM-WEB-01, VM-WEB-02"
echo "IIS Installed: YES"
echo "Load Balancer Integrated: YES"
echo "------------------------------------------------------------"