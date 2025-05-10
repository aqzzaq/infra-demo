output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "private_subnet_id"{
    value = azurerm_subnet.private_subnet.id
}

output "public_subnet_id"{
    value = azurerm_subnet.public_subnet.id
}


output "gateway_subnet_id"{
    value = azurerm_subnet.gateway_subnet.id
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}