provider "aws" {
  region = var.aws_region
  access_key = ""
  secret_key = ""  
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  credentials = file("")
}

provider "azurerm"{
  client_id = ""
  tenant_id = ""
  client_secret = ""
  subscription_id = ""
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


module "aws_network" {
  source = "./modules/aws/network"
  count = var.scale_operation == "true" ? 0: 1
  vpc_cidr            = var.aws_vpc_cidr
  availability_zone   = var.aws_availability_zone
  public_subnet_cidr  = var.aws_public_subnet_cidr
  private_subnet_cidr = var.aws_private_subnet_cidr
}
 
module "gcp_network" {
  source = "./modules/gcp/network"
  count = var.scale_operation == "true" ? 0: 1
  project_id          = var.gcp_project_id
  vpc_name            = "gcp-vpc"
  public_subnet_cidr  = var.gcp_public_subnet_cidr
  private_subnet_cidr = var.gcp_private_subnet_cidr
  region              = var.gcp_region
}

module "gcp_vpn_gateway" {
  source = "./modules/gcp/vpn-gateway"

  vpc_id       = module.gcp_network[0].vpc_id
  region       = var.gcp_region
  gcp_bgp_asn  = var.gcp_bgp_asn
}

module "aws_vpn" {
  source = "./modules/aws/vpn"

  vpc_id              = module.aws_network[0].vpc_id
  gcp_vpn_gateway_ips = module.gcp_vpn_gateway.ha_vpn_gateway_ips
  shared_secret       = var.shared_secret
  aws_bgp_asn         = var.aws_bgp_asn
  gcp_bgp_asn         = var.gcp_bgp_asn
  private_route_table_id = module.aws_network[0].private_route_table_id
  public_route_table_id = module.aws_network[0].public_route_table_id
}

module "gcp_vpn_tunnels" {
  depends_on = [module.aws_vpn]

  source = "./modules/gcp/vpn-tunnels"

  vpc_id                = module.gcp_network[0].vpc_id
  region                = var.gcp_region
  gcp_bgp_asn           = var.gcp_bgp_asn
  shared_secret         = var.shared_secret
  aws_vpn_gateway_ips   = module.aws_vpn.vpn_gateway_public_ips
  azure_vpn_gateway_ips = module.azure_spoke_vpn.vpn_gateway_public_ips
  aws_tunnel1_bgp_asn   = module.aws_vpn.aws_tunnel1_bgp_asn
  aws_tunnel2_bgp_asn   = module.aws_vpn.aws_tunnel2_bgp_asn
  aws_tunnel3_bgp_asn   = module.aws_vpn.aws_tunnel3_bgp_asn
  aws_tunnel4_bgp_asn   = module.aws_vpn.aws_tunnel4_bgp_asn  
  ha_vpn_gateway_id     = module.gcp_vpn_gateway.ha_vpn_gateway_id
  azure_bgp_asn         = var.azure_spoke_bgp_asn
  
}

module "azure_network" {
  source = "./modules/azure/network"
  count  = var.scale_operation == "true" ? 0: 1
  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment
  vnet_cidr           = var.vnet_cidr
  subnets             = var.subnets
  nsg_rules           = var.nsg_rules
}

module "azure_spoke_vpn" {
  depends_on = [module.azure_network[0]]
  source = "./modules/azure/vpn"

  resource_group_name  = var.resource_group_name
  location             = var.location
  gateway_subnet_id    = module.azure_network[0].gateway_subnet_id
  gcp_bgp_asn         = var.gcp_bgp_asn
  azure_spoke_bgp_asn  = var.azure_spoke_bgp_asn
  shared_secret       = var.shared_secret
  gcp_vpn_gateway_ips = module.gcp_vpn_gateway.ha_vpn_gateway_ips
}

module "aws_master_node" {
  source = "./modules/aws/compute/master"
  aws_master_name = var.aws_ec2_master_name
  aws_master_count = var.aws_master_count
  instance_type = var.aws_instance_type
  aws_subnet_id = var.scale_operation == "true" ? var.aws_private_subnet_id: module.aws_network[0].private_subnet_id
  aws_security_groups = var.scale_operation == "true" ? [var.aws_security_group_id]: [module.aws_network[0].security_group_id]

}

module "aws_worker_node" {
  source = "./modules/aws/compute/worker"
  aws_worker_name = var.aws_ec2_worker_name
  aws_worker_count = var.aws_worker_count
  instance_type = var.aws_instance_type  
  aws_subnet_id = var.scale_operation == "true" ? var.aws_private_subnet_id: module.aws_network[0].private_subnet_id
  aws_security_groups = var.scale_operation == "true" ? [var.aws_security_group_id]: [module.aws_network[0].security_group_id]
}

module "azure_master_node" {
  source = "./modules/azure/compute/master"
  azure_master_name = var.azure_vm_master_name
  azure_master_count = var.azure_master_count
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.scale_operation == "true" ? var.azure_subnet_id: module.azure_network[0].private_subnet_id
  vm_size = var.azure_vm_size
}

module "azure_worker_node" {
  source = "./modules/azure/compute/worker"
  azure_worker_name = var.azure_vm_worker_name
  azure_worker_count = var.azure_worker_count
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.scale_operation == "true" ? var.azure_subnet_id: module.azure_network[0].private_subnet_id
  vm_size = var.azure_vm_size
}

module "gcp_master_node"{
  source = "./modules/gcp/compute/master"
  gcp_master_name = var.gcp_compute_instance_master_name
  gcp_master_count = var.gcp_master_count
  machine_type = var.gcp_machine_type
  vpc_name = var.scale_operation == "true" ? var.gcp_vpc_name: module.gcp_network[0].vpc_name
  subnet_name = var.scale_operation == "true" ? var.gcp_subnet_name: module.gcp_network[0].subnet_name
}

module "gcp_worker_node"{
  source = "./modules/gcp/compute/worker"
  gcp_worker_name = var.gcp_compute_instance_worker_name
  gcp_worker_count = var.gcp_worker_count
  machine_type = var.gcp_machine_type
  gcp_region = var.gcp_region
  vpc_name = var.scale_operation == "true" ? var.gcp_vpc_name: module.gcp_network[0].vpc_name
  subnet_name = var.scale_operation == "true" ? var.gcp_subnet_name: module.gcp_network[0].subnet_name
}