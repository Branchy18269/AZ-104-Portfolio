Lab 07 README
Project: Self Guided AZ104 - Using Done Right Tech Company Resources

Objective
The goal of this lab is to implement a secure, enterprise-grade storage solution for Done Right Tech Company. By utilizing Azure File Shares and Storage Network ACLs, we demonstrate how to provide scalable cloud storage that is protected from external threats and only accessible to authorized internal networks.

Technical Tasks

Secure Storage Provisioning: Deploying a StorageV2 account with mandatory HTTPS and disabled public blob access.

File Share Configuration: Establishing an SMB-based Azure File Share with a defined 100GB quota for backup operations.

Network Hardening: Implementing a "Deny by Default" firewall policy, allowing traffic only from the DRTC core virtual network.

Secret Management: Utilizing the Azure CLI to programmatically retrieve storage access keys for secure integration.

Storage Architecture

1. Secure Storage Account

Redundancy: Standard_LRS (Locally Redundant Storage).

Security: All traffic is encrypted in transit via TLS 1.2. Public internet access is disabled at the firewall level.

2. Azure File Share (drtc-backups)

Protocol: SMB 3.0.

Use Case: Provides a centralized location for DRTC technicians to store diagnostic tools and system backups that can be mounted as a network drive on both Azure VMs and on-premises workstations (via VPN).

3. Network Access Controls

Default Action: Deny.

Exception: Traffic originating from VNET-DRTC-EAST / Subnet-Core is explicitly allowed. This ensures data cannot be exfiltrated to unauthorized networks.

Deployment Instructions

Prerequisites: Lab 04 must be complete to ensure the target Virtual Network (VNET-DRTC-EAST) exists for the firewall rules to bind to.

Execution:

chmod +x deploy_lab07.sh

./deploy_lab07.sh

Verification
Confirm the network firewall settings:
az storage account show --name  --resource-group RG-AZ104-PROD --query networkRuleSet

Confirm the file share exists:
az storage share list --account-name  --output table