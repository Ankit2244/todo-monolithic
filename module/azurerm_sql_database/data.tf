# data "azurerm_mssql_server" "sql_server_data" {
#   for_each            = var.sql_db_name
#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
# }
