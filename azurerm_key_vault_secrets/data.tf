data "azurerm_key_vault" "keyvaultdatablock" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}