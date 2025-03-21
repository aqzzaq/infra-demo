provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}


module "aws_network" {
  source = "./modules/aws/network"
  vpc_cidr            = var.aws_vpc_cidr
  availability_zone   = var.aws_availability_zone
  public_subnet_cidr  = var.aws_public_subnet_cidr
  private_subnet_cidr = var.aws_private_subnet_cidr
}
 
module "gcp_network" {
  source = "./modules/gcp/network"
  project_id          = var.gcp_project_id
  vpc_name            = var.gcp_vpc_name
  public_subnet_cidr  = var.gcp_public_subnet_cidr
  private_subnet_cidr = var.gcp_private_subnet_cidr
  region              = var.gcp_region
}

module "gcp_vpn_gateway" {
  source = "./modules/gcp/vpn-gateway"

  vpc_id       = module.gcp_network.vpc_id
  region       = var.gcp_region
  gcp_bgp_asn  = var.gcp_bgp_asn
}

module "aws_vpn" {
  source = "./modules/aws/vpn"

  vpc_id              = module.aws_network.vpc_id
  gcp_vpn_gateway_ips = module.gcp_vpn_gateway.ha_vpn_gateway_ips
  shared_secret       = var.shared_secret
  aws_bgp_asn         = var.aws_bgp_asn
  gcp_bgp_asn         = var.gcp_bgp_asn
  private_route_table_id = module.aws_network.private_route_table_id
  public_route_table_id = module.aws_network.public_route_table_id
}

module "gcp_vpn_tunnels" {
  depends_on = [module.aws_vpn]

  source = "./modules/gcp/vpn-tunnels"

  vpc_id                = module.gcp_network.vpc_id
  region                = var.gcp_region
  gcp_bgp_asn           = var.gcp_bgp_asn
  shared_secret         = var.shared_secret
  aws_vpn_gateway_ips   = module.aws_vpn.vpn_gateway_public_ips
  aws_tunnel1_bgp_asn   = module.aws_vpn.aws_tunnel1_bgp_asn
  aws_tunnel2_bgp_asn   = module.aws_vpn.aws_tunnel2_bgp_asn
  aws_tunnel3_bgp_asn   = module.aws_vpn.aws_tunnel3_bgp_asn
  aws_tunnel4_bgp_asn   = module.aws_vpn.aws_tunnel4_bgp_asn  
  ha_vpn_gateway_id     = module.gcp_vpn_gateway.ha_vpn_gateway_id
}
