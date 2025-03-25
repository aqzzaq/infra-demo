resource "azurerm_public_ip" "azure_vpn_ip1" {
  name                = "azure-vpn-ip1"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "azure_vpn_ip2" {
  name                = "azure-vpn-ip2"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "azure_spoke_vpn_gw" {
  name                = "azure-vpn-gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw2"
  active_active       = true
  enable_bgp          = true       

  ip_configuration {
    name                          = "azure-vpn-config1"
    public_ip_address_id          = azurerm_public_ip.azure_vpn_ip1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
  ip_configuration {
    name                          = "azure-vpn-config2"
    public_ip_address_id          = azurerm_public_ip.azure_vpn_ip2.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
  bgp_settings {
    asn = var.azure_spoke_bgp_asn
    peering_addresses {
        ip_configuration_name =  "azure-vpn-config1"
        apipa_addresses = ["169.254.21.1"]
    }
    peering_addresses {
        ip_configuration_name =  "azure-vpn-config2"
        apipa_addresses = ["169.254.22.1"]
    }
  }
}

resource "azurerm_local_network_gateway" "azure-google-locgateway1" {
  name                = "azure-google-locgateway1"
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.gcp_vpn_gateway_ips[0]
  bgp_settings {
    asn = var.gcp_bgp_asn
    bgp_peering_address = "169.254.21.2"
  }
}

resource "azurerm_local_network_gateway" "azure-google-locgateway2" {
  name                = "azure-google-locgateway2"
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.gcp_vpn_gateway_ips[1]
  bgp_settings {
    asn = var.gcp_bgp_asn
    bgp_peering_address = "169.254.22.2"
  }
}

resource "azurerm_virtual_network_gateway_connection" "azure_spoke_to_gcp_hub1" {
  name                = "azure-spoke-to-gcp-hub1"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                            = "IPsec"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.azure_spoke_vpn_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure-google-locgateway1.id
  shared_key = var.shared_secret
  enable_bgp = true
  connection_protocol = "IKEv2"
}

resource "azurerm_virtual_network_gateway_connection" "azure_spoke_to_gcp_hub2" {
  name                = "azure-spoke-to-gcp-hub2"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                            = "IPsec"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.azure_spoke_vpn_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.azure-google-locgateway2.id
  shared_key = var.shared_secret
  enable_bgp = true
  connection_protocol = "IKEv2"
}