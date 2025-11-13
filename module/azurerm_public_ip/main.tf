# resource "azurerm_public_ip" "public-ip" {
#     for_each = var.pip
#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location
#   allocation_method   = each.value.allocation_method

#   tags = {
#     environment = "Production"
#   }
# }


resource "azurerm_public_ip" "public_ip" {
  for_each = var.pip
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  allocation_method       = lookup(each.value, "allocation_method", "Static")
  sku                     = lookup(each.value, "sku", "Standard")
  ip_version              = lookup(each.value, "ip_version", "IPv4")
  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", 4)
  zones                   = lookup(each.value, "zones", [])

  # ✅ DNS now handled as top-level attributes
  domain_name_label = try(each.value.dns_settings.domain_name_label, null)
  reverse_fqdn      = try(each.value.dns_settings.reverse_fqdn, null)

  tags = merge(
    {
      environment = lookup(each.value, "environment", "Production")
    },
    lookup(each.value, "tags", {})
  )
}

