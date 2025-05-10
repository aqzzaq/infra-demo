resource "google_compute_external_vpn_gateway" "aws_vpn_gw" {
  count = length(var.aws_vpn_gateway_ips) >= 4 ? 1 : 0

  name            = "aws-vpn-gateway"
  redundancy_type = "FOUR_IPS_REDUNDANCY"
  interface {
    id         = 0
    ip_address = var.aws_vpn_gateway_ips[0]
  }
  interface {
    id         = 1
    ip_address = var.aws_vpn_gateway_ips[1]
  }
  interface {
    id         = 2
    ip_address = var.aws_vpn_gateway_ips[2]
  }
  interface {
    id         = 3
    ip_address = var.aws_vpn_gateway_ips[3]
  }    
}

resource "google_compute_external_vpn_gateway" "azure_vpn_gw" {
  count = length(var.azure_vpn_gateway_ips) >= 2 ? 1 : 0

  name            = "azure-vpn-gateway"
  redundancy_type = "TWO_IPS_REDUNDANCY"
  interface {
    id         = 0
    ip_address = var.azure_vpn_gateway_ips[0]
  }
  interface {
    id         = 1
    ip_address = var.azure_vpn_gateway_ips[1]
  }
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name                            = "tunnel1"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws_vpn_gw[0].id
  peer_external_gateway_interface = 0
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.aws_router.id
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name                            = "tunnel2"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws_vpn_gw[0].id
  peer_external_gateway_interface = 1
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.aws_router.id
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel3" {
  name                            = "tunnel3"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws_vpn_gw[0].id
  peer_external_gateway_interface = 2
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.aws_router.id
  vpn_gateway_interface           = 1
}

resource "google_compute_vpn_tunnel" "tunnel4" {
  name                            = "tunnel4"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws_vpn_gw[0].id
  peer_external_gateway_interface = 3
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.aws_router.id
  vpn_gateway_interface           = 1
}

resource "google_compute_vpn_tunnel" "azure_tunnel1" {
  name                            = "azure-tunnel1"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.azure_vpn_gw[0].id
  peer_external_gateway_interface = 0
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.azure_router.id
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "azure_tunnel2" {
  name                            = "azure-tunnel2"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.azure_vpn_gw[0].id
  peer_external_gateway_interface = 1
  shared_secret                   = var.shared_secret
  router                          = google_compute_router.azure_router.id
  vpn_gateway_interface           = 1
}

resource "google_compute_router" "aws_router" {
  name    = "gcp-aws-router"
  network = var.vpc_id
  bgp {
    asn = var.gcp_bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "10.1.0.0/16"
    }
  }
}

resource "google_compute_router" "azure_router" {
  name    = "gcp-azure-router"
  network = var.vpc_id
  bgp {
    asn = var.gcp_bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "192.168.0.0/16"
    }
  }
}

resource "google_compute_router_interface" "interface1" {
  name       = "interface1"
  router     = google_compute_router.aws_router.name
  region     = var.region
  ip_range   = "169.254.10.2/30"  
  vpn_tunnel = google_compute_vpn_tunnel.tunnel1.name
}

resource "google_compute_router_interface" "interface2" {
  name       = "interface2"
  router     = google_compute_router.aws_router.name
  region     = var.region
  ip_range   = "169.254.20.2/30" 
  vpn_tunnel = google_compute_vpn_tunnel.tunnel2.name
}

resource "google_compute_router_interface" "interface3" {
  name       = "interface3"
  router     = google_compute_router.aws_router.name
  region     = var.region
  ip_range   = "169.254.30.2/30"  
  vpn_tunnel = google_compute_vpn_tunnel.tunnel3.name
}

resource "google_compute_router_interface" "interface4" {
  name       = "interface4"
  router     = google_compute_router.aws_router.name
  region     = var.region
  ip_range   = "169.254.40.2/30" 
  vpn_tunnel = google_compute_vpn_tunnel.tunnel4.name
}

resource "google_compute_router_interface" "azure_interface1" {
  name       = "azure-interface1"
  router     = google_compute_router.azure_router.name
  region     = var.region
  ip_range   = "169.254.21.2/30"  
  vpn_tunnel = google_compute_vpn_tunnel.azure_tunnel1.name
}

resource "google_compute_router_interface" "azure_interface2" {
  name       = "azure-interface2"
  router     = google_compute_router.azure_router.name
  region     = var.region
  ip_range   = "169.254.22.2/30" 
  vpn_tunnel = google_compute_vpn_tunnel.azure_tunnel2.name
}

resource "google_compute_router_peer" "aws-conn1-tunn1" {
  name                      = "aws-conn1-tunn1"
  router                    = google_compute_router.aws_router.name
  region                    = var.region
  peer_ip_address           = "169.254.10.1" 
  peer_asn                  = var.aws_tunnel1_bgp_asn
  interface                 = google_compute_router_interface.interface1.name
}

resource "google_compute_router_peer" "aws-conn1-tunn2" {
  name                      = "aws-conn1-tunn2"
  router                    = google_compute_router.aws_router.name
  region                    = var.region
  peer_ip_address           = "169.254.20.1"  
  peer_asn                  = var.aws_tunnel2_bgp_asn
  interface                 = google_compute_router_interface.interface2.name
}
resource "google_compute_router_peer" "aws-conn2-tunn1" {
  name                      = "aws-conn2-tunn1"
  router                    = google_compute_router.aws_router.name
  region                    = var.region
  peer_ip_address           = "169.254.30.1" 
  peer_asn                  = var.aws_tunnel3_bgp_asn
  interface                 = google_compute_router_interface.interface3.name
}
resource "google_compute_router_peer" "aws-conn2-tunn2" {
  name                      = "aws-conn2-tunn2"
  router                    = google_compute_router.aws_router.name
  region                    = var.region
  peer_ip_address           = "169.254.40.1" 
  peer_asn                  = var.aws_tunnel4_bgp_asn
  interface                 = google_compute_router_interface.interface4.name
}

resource "google_compute_router_peer" "azure-tunn1" {
  name                      = "azure-tunn1"
  router                    = google_compute_router.azure_router.name
  region                    = var.region
  peer_ip_address           = "169.254.21.1" 
  peer_asn                  = var.azure_bgp_asn
  interface                 = google_compute_router_interface.azure_interface1.name
}

resource "google_compute_router_peer" "azure-tunn2" {
  name                      = "azure-tunn2"
  router                    = google_compute_router.azure_router.name
  region                    = var.region
  peer_ip_address           = "169.254.22.1"  
  peer_asn                  = var.azure_bgp_asn
  interface                 = google_compute_router_interface.azure_interface2.name
}

resource "google_network_connectivity_hub" "gcp_hub" {
  name                      = "gcp-hub"
  description               = "gcp hub to allow data exchange between azure and aws" 
}

resource "google_network_connectivity_spoke" "aws_spoke" {
  name        = "aws-spoke"
  location    = "us-central1"
  description = "Spoke for AWS site"
  hub = google_network_connectivity_hub.gcp_hub.id
  linked_vpn_tunnels {
    uris                       = [
                                    google_compute_vpn_tunnel.tunnel1.self_link, 
                                    google_compute_vpn_tunnel.tunnel2.self_link, 
                                    google_compute_vpn_tunnel.tunnel3.self_link, 
                                    google_compute_vpn_tunnel.tunnel4.self_link, 
                                  ]
    site_to_site_data_transfer = true
    include_import_ranges      = ["ALL_IPV4_RANGES"]
  }
  
}

resource "google_network_connectivity_spoke" "azure_spoke" {
  name        = "azure-spoke"
  location    = var.region
  description = "Spoke for Azure site"
  hub = google_network_connectivity_hub.gcp_hub.id
  linked_vpn_tunnels {
    uris                       = [
                                    google_compute_vpn_tunnel.azure_tunnel1.self_link,
                                    google_compute_vpn_tunnel.azure_tunnel2.self_link
                                  ]
    site_to_site_data_transfer = true
    include_import_ranges      = ["ALL_IPV4_RANGES"]
  }
}