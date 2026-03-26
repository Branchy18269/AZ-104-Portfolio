#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 02: Manage Subscriptions and RBAC
# Description: Governance, Resource Groups, Tagging, and Resource Locks
# ==============================================================================

# --- Step 1: Configuration ---
DOMAIN="${1:-drtc.net}"
LOCATION="eastus"
RG_NAME="RG-AZ104-PROD"
TAG_PROJECT="AZ104-SelfGuided"
TAG_OWNER="DRTC-IT"

echo "------------------------------------------------------------"
echo "Starting Lab 02: Governance and RBAC"
echo "Targeting Location: $LOCATION"
echo "------------------------------------------------------------"

# Fetch the active Subscription ID dynamically
SUB_ID=$(az account show --query id -o tsv)

# --- Step 2: Resource Group Creation & Tagging ---
echo "[RG-CREATE] Creating Resource Group: $RG_NAME..."
az group create --name "$RG_NAME" --location "$LOCATION" \
    --tags Project="$TAG_PROJECT" Owner="$TAG_OWNER" Environment="Production"

# --- Step 3: Resource Locking ---
echo "[LOCK-APPLY] Applying CanNotDelete Lock to $RG_NAME..."
az lock create --name "Protect-Core-Resources" \
    --resource-group "$RG_NAME" \
    --lock-type CanNotDelete \
    --notes "Prevent accidental deletion of AZ104 lab resources for DRTC."

# --- Step 4: Role-Based Access Control (RBAC) ---
USER_UPN="WillH@$DOMAIN"
echo "[RBAC-ASSIGN] Assigning Virtual Machine Contributor to $USER_UPN..."

# Retrieve the User Object ID
USER_ID=$(az ad user show --id "$USER_UPN" --query id -o tsv)

if [ -n "$USER_ID" ]; then
    az role assignment create \
        --assignee "$USER_ID" \
        --role "Virtual Machine Contributor" \
        --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_NAME"
    echo "Assignment successful."
else
    echo "[ERROR] User $USER_UPN not found. Ensure Lab 01 was completed."
fi

# --- Step 5: Azure Policy Assignment ---
echo "[POLICY-ASSIGN] Restricting VM sizes to B-Series (Cost Control)..."
POLICY_NAME="Restrict-VM-Size"

# FIXED LOGIC: Dynamically query the policy ID using the strict case-sensitive display name "SKUs"
POLICY_ID=$(az policy definition list --query "[?displayName=='Allowed virtual machine size SKUs'].name" -o tsv | head -n 1)

az policy assignment create --name "$POLICY_NAME" \
    --policy "$POLICY_ID" \
    --params "{ \"listOfAllowedSKUs\": { \"value\": [ \"Standard_B1s\", \"Standard_B2s\" ] } }" \
    --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_NAME"

# --- Step 6: Verification ---
echo "------------------------------------------------------------"
echo "LAB 02 COMPLETE"
echo "Resource Group: $(az group show --name $RG_NAME --query name -o tsv)"
echo "Lock Status: $(az lock list --resource-group $RG_NAME --query "[0].level" -o tsv)"
echo "Policy Applied: $POLICY_NAME"
echo "------------------------------------------------------------"