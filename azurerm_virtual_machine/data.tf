data "azurerm_subnet" "subnetdatablock" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "pipdatablock" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}


data "azurerm_key_vault_secret" "usernameblock" {
  name         = var.secret_user_name
  key_vault_id = data.azurerm_key_vault.keyvaultdatablock.id
}
data "azurerm_key_vault_secret" "passwordblock" {
  name         = var.secret_password
  key_vault_id = data.azurerm_key_vault.keyvaultdatablock.id
}

data "azurerm_key_vault" "keyvaultdatablock" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}