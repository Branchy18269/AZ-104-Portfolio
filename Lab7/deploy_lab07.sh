#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 07: Azure Storage
# Description: Deploying Secure Storage Accounts and Azure File Shares
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="storage_adv.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 07: Advanced Azure Storage"
echo "Targeting Resource Group: $RG_NAME"
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning Secure Storage and File Shares..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab07-Storage"

# Retrieve the Storage Account Name from the deployment
STG_NAME=$(az deployment group show -g "$RG_NAME" -n "AZ104-Lab07-Storage" --query properties.outputs.storageName.value -o tsv)

echo "[VERIFY] Retrieving Storage Access Keys..."
# This mimics a real-world task of getting credentials for a mount script
STORAGE_KEY=$(az storage account keys list -g "$RG_NAME" -n "$STG_NAME" --query "[0].value" -o tsv)

echo "------------------------------------------------------------"
echo "LAB 07 COMPLETE"
echo "Storage Account: $STG_NAME"
echo "File Share Created: drtc-backups"
echo "Network Firewall: Enabled (Restricted to VNET-DRTC-EAST)"
echo "------------------------------------------------------------"