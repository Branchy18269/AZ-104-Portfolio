#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 03: Manage Azure Resources
# Description: Deploying Storage and Networking via Bicep (IaC)
# ==============================================================================

# --- Step 1: Configuration ---
RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="main.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 03: Deploying Resources via Bicep"
echo "Target Resource Group: $RG_NAME"
echo "------------------------------------------------------------"

# --- Step 2: Pre-deployment Check ---
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "[ERROR] Bicep template not found: $TEMPLATE_FILE"
    exit 1
fi

# --- Step 3: Deployment ---
# We use 'az deployment group create' to deploy at the Resource Group level
echo "[BICEP-DEPLOY] Initiating deployment... this may take a moment."

az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab03-Deployment"

# --- Step 4: Verification ---
echo "[VERIFY] Fetching deployed resource details..."

STORAGE_NAME=$(az storage account list --resource-group "$RG_NAME" --query "[0].name" -o tsv)
VNET_NAME=$(az network vnet list --resource-group "$RG_NAME" --query "[0].name" -o tsv)

echo "------------------------------------------------------------"
echo "LAB 03 COMPLETE"
echo "Deployed Storage Account: $STORAGE_NAME"
echo "Deployed Virtual Network: $VNET_NAME"
echo "------------------------------------------------------------"