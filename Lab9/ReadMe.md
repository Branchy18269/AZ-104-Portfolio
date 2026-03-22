Lab 09 README
Project: Self Guided AZ104 - Using Done Right Tech Company Resources

Objective
The goal of this lab is to implement a robust disaster recovery and data protection strategy for Done Right Tech Company. By deploying a Recovery Services Vault and configuring automated backup policies, we ensure that the business can recover its compute infrastructure in the event of data corruption, accidental deletion, or ransomware.

Technical Tasks

Vault Provisioning: Deploying an Azure Recovery Services Vault with a focus on cost-efficient storage (LRS).

Backup Policy Engineering: Designing a daily retention schedule (30-day window) that balances recovery point objectives (RPO) with storage costs.

Workload Protection: Programmatically enabling backup for existing IaaS Virtual Machines using the Azure CLI.

Redundancy Management: Ensuring that the backup vault uses Locally Redundant Storage to comply with lab cost-management policies.

Data Protection Architecture

1. Recovery Services Vault (RSV-DRTC-PROD)
The vault acts as a centralized repository for backup data and recovery points. It is designed to be independent of the virtual machines it protects, providing a secure "off-box" backup solution.

2. Standard Backup Policy (Policy-Daily-VM)

Frequency: Daily at 11:00 PM UTC.

Retention: 30 days.

Management Type: Azure IaasVM (specifically optimized for Windows and Linux virtual machines).

3. Protected Workloads
Both VM-WEB-01 and VM-WEB-02 are registered with the vault. This process creates an initial backup point and schedules subsequent daily captures. In a real-world scenario, this allows for the restoration of an entire VM or individual files from within the server.

Deployment Instructions

Prerequisites: Lab 08 must be complete to ensure the target Virtual Machines exist.

Execution:

chmod +x deploy_lab09.sh

./deploy_lab09.sh

Verification
Confirm the backup protection status via the CLI:
az backup item list --vault-name RSV-DRTC-PROD --resource-group RG-AZ104-PROD --output table

Expected Result: The list should show both VMs with a Health State of "Passed" or "Initial backup pending."