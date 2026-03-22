Lab 06 README
Project: Self Guided AZ104 - Using Done Right Tech Company Resources

Objective
This lab focuses on implementing high-availability networking for Done Right Tech Company. By deploying a Standard Azure Load Balancer, we establish a single entry point for web traffic that can intelligently distribute requests across multiple backend servers and automatically stop sending traffic to any server that fails its health check.

Technical Tasks

Public Load Balancer Implementation: Provisioning a Standard SKU Load Balancer with a static frontend IP.

Health Monitoring: Configuring a TCP-based health probe to monitor the status of backend instances on Port 80.

Traffic Orchestration: Defining Load Balancing Rules to map incoming frontend traffic to the internal backend pool.

Infrastructure as Code: Utilizing Bicep to ensure the traffic management layer is reproducible and documented.

Traffic Management Components

1. Frontend IP (PIP-LB-DRTC)

Role: The public-facing "VIP" (Virtual IP) that users connect to.

SKU: Standard (Required for high-availability features and HTTPS support).

2. Health Probe (HTTP-Health-Probe)

Logic: Every 15 seconds, the Load Balancer checks if the backend servers are responding on Port 80.

Failure Condition: If a server fails two consecutive checks, it is removed from the rotation until it becomes healthy again.

3. Load Balancing Rule (HTTP-Traffic-Rule)

Protocol: TCP

Port Mapping: Frontend 80 -> Backend 80.

Persistence: Uses Default (Hash-based) distribution to balance traffic evenly.

Deployment Instructions

Prerequisites: Lab 02 must be complete to provide the target Resource Group.

Execution:

chmod +x deploy_lab06.sh

./deploy_lab06.sh

Verification
Confirm the Load Balancer rules are correctly provisioned via the CLI:
az network lb rule list --lb-name LB-DRTC-PROD --resource-group RG-AZ104-PROD --output table