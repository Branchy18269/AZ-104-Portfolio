Lab 03: Manage Azure Resources
Project: Self Guided AZ104 - Using Done Right Tech Company Resources
Objective
Transition from manual management to Infrastructure as Code (IaC). By utilizing Bicep templates, we ensure that Done Right Tech Company deployments are repeatable, consistent, and documented.

Technical Tasks
Declarative Templating: Developing Bicep modules to define cloud infrastructure.

Storage Provisioning: Deploying a StorageV2 account with a unique naming suffix.

Virtual Networking: Implementing a VNet with a segmented multi-subnet architecture (Web and App tiers).

Infrastructure Details
Storage Account: Configured as Standard_LRS for cost efficiency during the lab phase.

VNET-AZ104-PROD: Features a 10.0.0.0/16 address space with dedicated subnets for public-facing and internal resources.
