#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 04: Virtual Networking
# Description: Global VNet Peering between East US and West US
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="networking.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 04: Global Virtual Network Peering"
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning multi-region networks..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab04-Networking"

echo "[VERIFY] Checking Peering Status..."
az network vnet peering list -g "$RG_NAME" --vnet-name VNET-DRTC-EAST -o table

echo "------------------------------------------------------------"
echo "LAB 04 COMPLETE"
echo "------------------------------------------------------------"