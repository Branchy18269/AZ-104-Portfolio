#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 05: Intersite Connectivity
# Description: Deploying Azure Bastion and VPN Gateway
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="connectivity.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 05: Intersite Connectivity"
echo "WARNING: Virtual Network Gateways typically take 30-45 minutes to deploy."
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning Bastion and VPN Gateway..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab05-Connectivity" \
    --no-wait

echo "[INFO] Deployment started in 'No-Wait' mode."
echo "[INFO] You can monitor progress in the Portal or via: az deployment group show -g $RG_NAME -n AZ104-Lab05-Connectivity"

echo "------------------------------------------------------------"
echo "LAB 05 INITIATED"
echo "------------------------------------------------------------"