#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 01: Manage Microsoft Entra ID Identities
# Logic: First 5 of First Name + Last Initial
# Target Domain: drtc.net
# ==============================================================================

# --- Step 1: Configuration ---
# Defaults to drtc.net; can be overridden by passing an argument: ./deploy_lab01.sh contoso.com
DOMAIN="${1:-drtc.net}"
PASSWORD="ComplexPassword123!"

# SKU_ID for license assignment (e.g., Microsoft 365 E5)
SKU_ID="ENTER_YOUR_SKUID_HERE" 

echo "------------------------------------------------------------"
echo "Starting Project: Self Guided AZ104"
echo "Using DRTC Resources for Domain: $DOMAIN"
echo "------------------------------------------------------------"

# --- Step 2: User Data ---
target_users=("Will Hyndman" "Alison Totten" "Duncan Hine")

# --- Step 3: User Creation Loop ---
for full_name in "${target_users[@]}"; do
    first=$(echo $full_name | awk '{print $1}')
    last=$(echo $full_name | awk '{print $2}')
    
    # Custom Naming Logic: First 5 of First + Last Initial
    prefix=$(echo "$first" | cut -c 1-5)
    suffix=$(echo "$last" | cut -c 1)
    USERNAME="${prefix}${suffix}"
    UPN="$USERNAME@$DOMAIN"
    
    echo "[ID-CREATE] Creating: $UPN"
    
    az ad user create \
        --display-name "$full_name" \
        --password "$PASSWORD" \
        --user-principal-name "$UPN" \
        --department "IT" \
        --job-title "Technical Consultant" \
        --force-change-password-next-login true
done

# --- Step 4: Security Groups ---
echo "[GROUP-CREATE] Creating Static Security Group..."
az ad group create --display-name "DRTC-Internal-Staff" --mail-nickname "internalstaff"

# --- Step 5: Dynamic Groups (REQUIRES ENTRA ID P1/P2) ---
# NOTE: This feature is part of the premium tier. 
# It automates membership based on the 'Department' attribute set in Step 3.
echo "[GROUP-DYNAMIC] Creating Dynamic IT Group... (Requires P1/P2 License)"
az ad group create \
    --display-name "DRTC-Dynamic-IT" \
    --mail-nickname "dyn-it" \
    --membership-rule "(user.department -eq 'IT')" \
    --membership-rule-processing-state "On"

# --- Step 6: License Assignment ---
if [ "$SKU_ID" != "ENTER_YOUR_SKUID_HERE" ]; then
    echo "[LICENSE] Assigning licenses to users..."
    for full_name in "${target_users[@]}"; do
        first=$(echo $full_name | awk '{print $1}')
        last=$(echo $full_name | awk '{print $2}')
        prefix=$(echo "$first" | cut -c 1-5)
        suffix=$(echo "$last" | cut -c 1)
        UPN="${prefix}${suffix}@$DOMAIN"
        
        az ad user license add --id "$UPN" --add-licenses "$SKU_ID"
    done
else
    echo "[INFO] Skipping License Assignment: No SKU_ID provided."
fi

# --- Step 7: Final Verification ---
echo "------------------------------------------------------------"
echo "LAB 01 COMPLETE"
az ad user list --query "[?contains(userPrincipalName, '$DOMAIN')].{DisplayName:displayName, UPN:userPrincipalName}" -o table
echo "------------------------------------------------------------"