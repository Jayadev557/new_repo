resource "azurerm_key_vault_secret" "secretuserblock" {
  name         = var.secret_user_name
  value        = var.secret_user_value
  key_vault_id = data.azurerm_key_vault.keyvaultdatablock.id
}

resource "azurerm_key_vault_secret" "secretpasswdblock" {
  name         = var.secret_password
  value        = var.secret_password_value
  key_vault_id = data.azurerm_key_vault.keyvaultdatablock.id
}