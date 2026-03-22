Lab 04: Virtual Networking
Project: Self Guided AZ104 - Using Done Right Tech Company Resources
Objective
Configure and validate inter-site connectivity within the Azure global backbone. By implementing Virtual Network Peering, we enable private, low-latency communication between geographically dispersed regions without public internet exposure.

Technical Tasks
Multi-Region Provisioning: Deploying networks in East US and West US.

IP Address Management (IPAM): Designing non-overlapping address spaces to ensure routing compatibility.

Global VNet Peering: Configuring a bidirectional "handshake" between the Hub and Spoke networks.

Architecture
VNET-DRTC-EAST (Hub): 10.1.0.0/16

VNET-DRTC-WEST (Spoke): 10.2.0.0/16

Connectivity: The East-To-West and West-To-East peering states must show as Connected for valid communication.
