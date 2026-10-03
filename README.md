# Azure Hub-and-Spoke Network Architecture using Terraform

This project demonstrates the implementation of an Azure Hub-and-Spoke network architecture using Terraform.

The infrastructure uses a centralized Hub VNet with Azure Firewall to control traffic between Development and Production spoke networks. The spokes are not directly peered with each other. Instead, User Defined Routes (UDRs) route inter-spoke traffic through Azure Firewall, where Firewall Policy network rules control the communication.

The complete infrastructure is deployed using reusable Terraform modules.

## Architecture

The architecture consists of:

- **Hub VNet** – Provides centralized network connectivity and hosts Azure Firewall.
- **Azure Firewall** – Acts as the central network security and routing point for inter-spoke traffic.
- **Firewall Policy** – Contains network rules to control communication between the Dev and Prod spokes.
- **Dev Spoke VNet** – Contains the development workload.
- **Prod Spoke VNet** – Contains the production workload.
- **VNet Peering** – Connects both spokes with the Hub VNet.
- **User Defined Routes (UDRs)** – Route inter-spoke traffic through Azure Firewall as a virtual appliance.
- **Network Security Groups (NSGs)** – Provide subnet-level traffic filtering for the spoke workloads.

---
### High-Level Design
