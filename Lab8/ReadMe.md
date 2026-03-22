Lab 08 README
Project: Self Guided AZ104 - Using Done Right Tech Company Resources

Objective
This lab represents the final integration phase of the project. By deploying Windows Server 2022 virtual machines, we demonstrate how to leverage the identities, networking, storage, and traffic management layers built in previous modules. The focus is on implementing high-availability compute resources for Done Right Tech Company while following the cost-governance policies established earlier in the project.

Technical Tasks

Availability Set Configuration: Implementing an Availability Set with defined Fault and Update domains to provide 99.95% SLA protection.

Compute Provisioning: Deploying multiple Windows Server 2022 instances using the Standard_B2s SKU (as required by Lab 02 policy).

Automated Post-Deployment Configuration: Utilizing the Custom Script Extension to programmatically install IIS and create a unique landing page on each server.

Network Integration: Binding multiple Virtual Machines to the Load Balancer backend pool and internal subnets.

Compute Architecture

1. High Availability (AS-DRTC-WEB)
Virtual Machines are placed in an Availability Set. This ensures that during Azure platform updates or hardware failures, at least one server remains operational, maintaining service continuity for DRTC clients.

2. Virtual Machines (VM-WEB-01 / VM-WEB-02)

OS: Windows Server 2022 Datacenter.

Configuration: Managed via Bicep loops to ensure identical builds across the web tier.

Storage: Standard_LRS managed disks to balance performance and cost.

3. The Web Application Layer
Each VM runs a PowerShell-based post-deployment script. This script:

Installs the Web-Server (IIS) role.

Overwrites the default IIS page to display the specific hostname of the server. This allows for clear verification of the Load Balancer's distribution logic in Lab 06.

Deployment Instructions

Prerequisites: Lab 04 (Networking) and Lab 06 (Load Balancer) must be deployed first.

Execution:

chmod +x deploy_lab08.sh

./deploy_lab08.sh

Authentication: When prompted, enter a complex password that meets Azure's requirements (12+ characters, uppercase, lowercase, numbers, and symbols).

Verification
Retrieve the Load Balancer Public IP from Lab 06 and enter it into a web browser. Refresh the page several times to see the traffic toggle between VM-WEB-01 and VM-WEB-02.