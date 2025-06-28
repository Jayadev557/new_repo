data "azurerm_mssql_server" "sqlserverdbblock" {
  name                = var.sql_server_name
  resource_group_name = var.rg_name
}
