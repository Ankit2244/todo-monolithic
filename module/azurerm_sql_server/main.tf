# resource "azurerm_mssql_server" "sql_server" {
#   for_each = var.sql_server_name
#   name                         = each.value.name
#   resource_group_name          = each.value.resource_group_name
#   location                     = each.value.location
#   version                      = each.value.version
#   administrator_login          = each.value.administrator_login
#   administrator_login_password = each.value.administrator_login_password
#   minimum_tls_version          = each.value.minimum_tls_version

#   tags = each.value.tags
# }

resource "azurerm_mssql_server" "sql_server" {
  for_each                     = var.sql_servers
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = lookup(each.value, "version", "12.0")
  administrator_login          = each.value.admin_username
  administrator_login_password = each.value.admin_password
  minimum_tls_version          = lookup(each.value, "minimum_tls_version", "1.2")

  tags = merge(
    {
      environment = lookup(each.value, "environment", "dev")
      owner       = lookup(each.value, "owner", "team-devops")
    },
    lookup(each.value, "tags", {})
  )
}
