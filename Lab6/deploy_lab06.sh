#!/bin/bash

# ==============================================================================
# Project: Self Guided AZ104 - Using Done Right Tech Company Resources
# Lab 06: Network Traffic Management
# Description: Deploying a Standard Public Load Balancer for High Availability
# ==============================================================================

RG_NAME="RG-AZ104-PROD"
TEMPLATE_FILE="traffic.bicep"

echo "------------------------------------------------------------"
echo "Starting Lab 06: Network Traffic Management"
echo "Targeting Resource Group: $RG_NAME"
echo "------------------------------------------------------------"

echo "[BICEP-DEPLOY] Provisioning Load Balancer, Health Probes, and Rules..."
az deployment group create \
    --resource-group "$RG_NAME" \
    --template-file "$TEMPLATE_FILE" \
    --name "AZ104-Lab06-Traffic"

echo "[VERIFY] Fetching Load Balancer Public IP..."
LB_IP=$(az network public-ip show -g "$RG_NAME" -n PIP-LB-DRTC --query ipAddress -o tsv)

echo "------------------------------------------------------------"
echo "LAB 06 COMPLETE"
echo "Load Balancer Public IP: $LB_IP"
echo "Backend Pool: LB-Backend-Pool"
echo "Status: Active and Monitoring Port 80"
echo "------------------------------------------------------------"