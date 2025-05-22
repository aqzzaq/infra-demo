# infra-demo

## Intro
This repo contains the terraform script to create a multi-cloud infrastructure which includes resources from GCP, AWS, and Azure. If all modules were executed from the main.tf in root directory, the end result would contain VMs created from all three providers inter-connected to each other through VPN networks.
The VPN structure in this repo adopts a hub and spoke configuration where GCP was used as the hub where AWS and Azure were the spokes.
The intention of this repo is to be used as a pre-requisite backbone for a multi-cloud kubernetes cluster.

## Modules

### AWS Network
Contains the resources to create the AWS network.
### AWS VPN
Contains the resource to create the vpn configuration on AWS side to connect with the GCP hub.
### AWS Compute
Contains the resource to create VMs from AWS.

### Azure Network
Contains the resources to create the Azure network.
### Azure VPN
Contains the resource to create the vpn configuration on Azure side to connect with the GCP hub.
### Azure Compute
Contains the resource to create VMs from Azure.

### GCP Network
Contains the resources to create the GCP network.
### GCP VPN
Contains the resource to create the vpn configuration for GCP hub to connect with the AWS and Azure spokes.
### GCP Compute
Contains the resource to create VMs from GCP.
