# Self Guided AZ104 - Using Done Right Tech Company Resources

## Project Overview
This repository serves as a comprehensive, end-to-end technical demonstration of the **Microsoft Azure Administrator (AZ-104)** curriculum. Unlike standard lab environments, this project is implemented within a simulated corporate context for **Done Right Tech Company (DRTC)**. 

Every resource—from identity management to automated backups—is deployed using **Infrastructure as Code (Bicep)** and **Azure CLI**, ensuring a repeatable, governed, and professional-grade cloud architecture.

---

## Lab Curriculum & Progress

| Lab | Title | Key Technical Deliverable |
| :--- | :--- | :--- |
| **01** | **Identity & Entra ID** | Custom naming logic (First 5 + Last Initial) and Dynamic Groups. |
| **02** | **Governance & RBAC** | Azure Policy for cost control and Resource Locks for protection. |
| **03** | **Azure Resources (IaC)** | Modular deployment of Storage and Networking via Bicep. |
| **04** | **Virtual Networking** | Global VNet Peering between East US and West US regions. |
| **05** | **Intersite Connectivity** | Secure management via Azure Bastion and VPN Gateways. |
| **06** | **Traffic Management** | High-availability via Standard Public Load Balancer. |
| **07** | **Advanced Storage** | Secure SMB File Shares with VNet-restricted firewalls. |
| **08** | **Virtual Machines** | Windows Server 2022 Availability Sets with automated IIS provisioning. |
| **09** | **Data Protection** | Recovery Services Vault with automated daily backup policies. |
| **10** | **Monitoring** | Log Analytics integration and proactive CPU threshold alerts. |

---

## Core Engineering Principles

### 1. Identity Standard (DRTC-ID)
To simulate real-world enterprise constraints, all identities follow the **DRTC Standard**:
* **Naming Convention:** [First 5 of First Name][First Letter of Last Name]
* **Example:** Will Hyndman → **WillH@drtc.net**

### 2. Infrastructure as Code (Bicep)
Moving away from manual portal clicks, this project utilizes **Bicep** for resource orchestration. This ensures that the **Done Right Tech Company** environment can be torn down and redeployed in minutes with 100% consistency.

### 3. Cost & Compliance Governance
Financial responsibility is built into the architecture:
* **Azure Policy:** Restricts deployments to cost-effective B-Series virtual machines.
* **Resource Tagging:** Every resource is tagged with **Project: AZ104-SelfGuided** and **Owner: DRTC-IT** for transparent billing.

### 4. Zero-Trust Security
Security is not an afterthought:
* **Azure Bastion:** No RDP/SSH ports are open to the public internet.
* **Storage Firewalls:** Data is only accessible from within the corporate VNet.
* **RBAC:** Users are granted "Contributor" roles only at the Resource Group level, following the principle of least privilege.

---

## Getting Started

### Prerequisites
* An active Azure Subscription.
* Azure CLI installed locally.
* A verified domain (defaulting to **drtc.net** in scripts).

### How to Run
Each lab is contained within its own directory. To deploy a specific phase of the project:
1. Navigate to the desired Lab folder (e.g., **cd Lab01-EntraID**).
2. Ensure the deployment script has execution permissions: **chmod +x deploy_labXX.sh**.
3. Execute the script: **./deploy_labXX.sh**.

---

## About the Author
**Will Hyndman** *Founder, Done Right Tech Company* *IT Systems Management and Security Student* This project is a living document of my journey toward the **AZ-104 Microsoft Azure Administrator** certification, showcasing a blend of academic rigor and practical, business-focused cloud engineering.