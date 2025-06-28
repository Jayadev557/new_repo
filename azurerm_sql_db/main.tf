resource "azurerm_mssql_database" "sqldbblock" {
  name         = var.sql_db_name
  server_id    = data.azurerm_mssql_server.sqlserverdbblock.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 5
  sku_name     = "S0"
}