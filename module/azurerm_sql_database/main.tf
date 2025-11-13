resource "azurerm_mssql_database" "sql_db" {
  for_each = var.sql_db_name
  name         = each.value.name
  server_id    = each.value.server_id
  collation    = lookup(each.value, "collation", "SQL_Latin1_General_CP1_CI_AS")
  license_type = lookup(each.value, "license_type", "LicenseIncluded")
  max_size_gb  = lookup(each.value, "max_size_gb", 2)
  sku_name     = lookup(each.value, "sku_name", "S0")
  enclave_type = lookup(each.value, "enclave_type", "VBS")
}