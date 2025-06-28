resource "azurerm_mssql_server" "sqlserverblock" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_server_login_id
  administrator_login_password = var.sql_server_password
  minimum_tls_version          = "1.2"
}