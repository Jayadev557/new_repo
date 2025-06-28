module "resource_group" {
  source   = "../azurerm_resource_group"
  rg_name  = "infra-rg"
  location = "Central India"
}

module "virtual_network" {
  source        = "../azurerm_virtual_network"
  depends_on    = [module.resource_group]
  vnet_name     = "infra-vnet"
  location      = "Central India"
  rg_name       = "infra-rg"
  address_space = ["10.0.0.0/24"]
}

module "frontend_subnet" {
  source           = "../azurerm_subnet"
  depends_on       = [module.virtual_network]
  subnet_name      = "front-subnet"
  rg_name          = "infra-rg"
  vnet_name        = "infra-vnet"
  address_prefixes = ["10.0.0.0/26"]
}

module "backend_subnet" {
  source           = "../azurerm_subnet"
  depends_on       = [module.virtual_network]
  subnet_name      = "back-subnet"
  rg_name          = "infra-rg"
  vnet_name        = "infra-vnet"
  address_prefixes = ["10.0.0.64/26"]
}

module "front_public_ip" {
  source            = "../azurerm_public_ip"
  depends_on        = [module.resource_group]
  pip_name          = "front-pip"
  rg_name           = "infra-rg"
  location          = "Central India"
  allocation_method = "Static"
}

module "back_public_ip" {
  source            = "../azurerm_public_ip"
  depends_on        = [module.resource_group]
  pip_name          = "back-pip"
  rg_name           = "infra-rg"
  location          = "Central India"
  allocation_method = "Static"
}

module "front_virtual_machine" {
  source      = "../azurerm_virtual_machine"
  depends_on  = [module.frontend_subnet, module.key_vault, module.key_vault_secret]
  subnet_name = "front-subnet"
  vnet_name   = "infra-vnet"
  rg_name     = "infra-rg"
  nic_name    = "front-nic"
  location    = "Central India"
  vm_name     = "front-vm"
  # vm_username = "adminuser"
  # vm_passowrd = "admin@123456"
  pip_name    = "front-pip"
  secret_user_name = "vmuser"
  secret_password = "vmpassword"
  key_vault_name = "infra-key1vault"
}

module "back_virtual_machine" {
  source      = "../azurerm_virtual_machine"
  depends_on  = [module.backend_subnet, module.key_vault, module.key_vault_secret]
  subnet_name = "back-subnet"
  vnet_name   = "infra-vnet"
  rg_name     = "infra-rg"
  nic_name    = "back-nic"
  location    = "Central India"
  vm_name     = "back-vm"
  # vm_username = "Abnishuser"
  # vm_passowrd = "Jetoo@123456"
  pip_name    = "back-pip"
  secret_user_name = "vmuser"
  secret_password = "vmpassword"
  key_vault_name = "infra-key1vault"
}

module "sql_server" {
  source              = "../azurerm_sql_server"
  depends_on          = [module.resource_group]
  sql_server_name     = "infra-server"
  rg_name             = "infra-rg"
  location            = "Central India"
  sql_server_login_id = "Prashantuser"
  sql_server_password = "Jay@123456"
}

module "sql_database" {
  source          = "../azurerm_sql_db"
  depends_on = [ module.sql_server ]
  sql_db_name     = "infra-db"
  sql_server_name = "infra-server"
  rg_name         = "infra-rg"
}

module "key_vault" {
  source = "../azurerm_key_vault"
  depends_on = [ module.resource_group ]
  key_vault_name = "infra-key1vault"
  location = "Central India"
  rg_name = "infra-rg"
}

module "key_vault_secret" {
  source = "../azurerm_key_vault_secrets"
  depends_on = [ module.key_vault ]
  secret_user_name = "vmuser"
  secret_user_value = "adminuser"
  key_vault_name = "infra-key1vault"
  rg_name = "infra-rg"
  secret_password = "vmpassword"
  secret_password_value = "Password@1234"
}
