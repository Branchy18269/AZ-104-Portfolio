Lab 01: Manage Microsoft Entra ID Identities
Project: Self Guided AZ104 - Using Done Right Tech Company Resources
Objective
The goal of this lab is to demonstrate proficiency in identity management within Microsoft Entra ID. This includes automating user lifecycle management, implementing scalable group structures, and applying granular administrative roles using DRTC resources.

Technical Tasks
Custom Identity Provisioning: Automate user creation using a specific corporate naming convention.

Security Group Architecture: Configure both static and dynamic membership rules.

License Management: Programmatic assignment of Microsoft 365/Azure licenses.

Directory Role Delegation: Assigning the "User Administrator" role to a specific security group.

Identity Logic & Naming Convention
To mirror real-world enterprise requirements, this lab utilizes a custom naming logic for all Done Right Tech Company consultants:

Format: [First 5 Letters of First Name][First Letter of Last Name]

Default Domain: drtc.net

Provisioned Identities:

Will Hyndman: WillH@drtc.net

Alison Totten: AlisoT@drtc.net

Duncan Hine: DuncaH@drtc.net

Lab Components
1. Security Groups
DRTC-Internal-Staff (Static): A standard security group for manual membership management.

DRTC-Dynamic-IT (Dynamic): Automates membership for any user whose Department attribute is set to "IT".

Note: This feature requires an Entra ID P1 or P2 license to function.

2. RBAC & Directory Roles
The DRTC-IT-Admins group is granted the User Administrator directory role. This allows members of this group to manage user passwords and profiles without needing full Global Administrator privileges.

3. Licensing
The deployment script includes a module for automated license assignment via SkuId. This ensures that all new consultants are "Ready-to-Work" immediately upon creation.

Deployment Instructions
Prerequisites: Ensure you have the Azure CLI installed and are logged in via the command: az login.

Configuration: Open the deployment script and update the SKU_ID variable with your specific tenant's license ID.

Execution: Run the script from your terminal using the following commands:

chmod +x deploy_lab01.sh

./deploy_lab01.sh drtc.net

Verification
After execution, verify the results in the Entra ID portal or via the CLI with:
az ad group member list --group "DRTC-Dynamic-IT" --query "[].displayName"