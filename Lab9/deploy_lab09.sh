#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 09: Data Protection
# Description: Deploying Recovery Services Vault and enabling VM backups
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
VAULT_NAME="RSV-DRTC-PROD"
POLICY_NAME="Policy-Daily-VM"
TEMPLATE_FILE="backup.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 09: Data Protection"
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning Recovery Services Vault..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab09-Backup"

echo "[BACKUP-ENABLE] Registering VM-WEB-01 and VM-WEB-02..."

# Loop to enable backup for both VMs
vms=("VM-WEB-01" "VM-WEB-02")
for vm in "${vms[@]}"; do
    echo "Enabling backup for $vm..."
    az backup protection enable-for-vm \
        --resource-group "$RG_NAME" \
        --vault-name "$VAULT_NAME" \
        --vm "$vm" \
        --policy-name "$POLICY_NAME"
done

echo "------------------------------------------------------------"
echo "LAB 09 COMPLETE"
echo "Vault: $VAULT_NAME"
echo "Policy: $POLICY_NAME (Daily, 30-day retention)"
echo "Protected Items: VM-WEB-01, VM-WEB-02"
echo "------------------------------------------------------------"
