resource "azurerm_network_interface" "nicblock" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnetdatablock.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pipdatablock.id
  }
}

resource "azurerm_linux_virtual_machine" "vmblock" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = data.azurerm_key_vault_secret.usernameblock.value
  admin_password                  = data.azurerm_key_vault_secret.passwordblock.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nicblock.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
