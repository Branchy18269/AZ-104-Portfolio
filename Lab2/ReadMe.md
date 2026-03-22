Lab 02: Manage Subscriptions and RBAC
Project: Self Guided AZ104 - Using Done Right Tech Company Resources
Objective
Establish a governed and secure environment for the project. This includes implementing Infrastructure-as-Code (IaC) for resource organization, enforcing corporate metadata through tagging, and applying guardrails to prevent accidental data loss.

Technical Tasks
Standardized Organization: Provisioning production-grade Resource Groups (RGs).

Metadata & Tagging: Implementing a schema for billing (Project, Owner, Environment).

Infrastructure Protection: Configuring Resource Locks (CanNotDelete) on core components.

Governance via Azure Policy: Enforcing cost-control by restricting allowed VM sizes to the B-Series.

Security & Compliance
Resource Locks: Critical resources are protected by a CanNotDelete lock to prevent "fat-finger" deletions.

RBAC Precision: Delegating the Virtual Machine Contributor role to WillH@drtc.net at the Resource Group scope.

Cost Management: Any attempt to deploy an expensive VM series is automatically blocked by Azure Policy.
