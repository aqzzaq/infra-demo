resource "azurerm_linux_virtual_machine" "control_plane" {
  count               = var.azure_master_count
  name                = "${var.azure_master_name}-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size 
  admin_username      = "ubuntu"

  network_interface_ids = [
    azurerm_network_interface.control_plane_nic[count.index].id
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "control_plane_nic" {
  count               = var.azure_master_count
  name                = "${var.azure_master_name}-nic-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}