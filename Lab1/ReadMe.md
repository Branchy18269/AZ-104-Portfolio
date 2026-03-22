Lab 01: Manage Microsoft Entra ID Identities
Project: Self Guided AZ104 - Using Done Right Tech Company Resources
Objective
The goal of this lab is to demonstrate proficiency in identity management within Microsoft Entra ID. This involves automating user lifecycle management, implementing scalable group structures, and applying granular administrative roles using DRTC resources.

Technical Tasks
Custom Identity Provisioning: Automate user creation using a specific corporate naming convention.

Security Group Architecture: Configure both static and dynamic membership rules.

License Management: Programmatic assignment of Microsoft 365/Azure licenses.

Directory Role Delegation: Assigning the User Administrator role to a specific security group.

Identity Logic & Naming Convention
To mirror real-world enterprise requirements, this lab utilizes a custom naming logic for all Done Right Tech Company consultants:

Format: [First 5 Letters of First Name][First Letter of Last Name]

Default Domain: drtc.net

Provisioned Identities:

Will Hyndman: WillH@drtc.net

Alison Totten: AlisoT@drtc.net

Duncan Hine: DuncaH@drtc.net

Lab Components
DRTC-Internal-Staff (Static): A standard security group for manual membership.

DRTC-Dynamic-IT (Dynamic): Automates membership for any user whose Department attribute is set to "IT". (Requires Entra ID P1/P2).

RBAC: The DRTC-IT-Admins group is granted the User Administrator directory role to follow the principle of least privilege.

Deployment & Verification
Run chmod +x deploy_lab01.sh then ./deploy_lab01.sh.

Verify via CLI: az ad group member list --group "DRTC-Dynamic-IT" --query "[].displayName"
