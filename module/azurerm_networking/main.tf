# resource "azurerm_virtual_network" "networking" {
#   for_each            = var.vnets
#   name                = each.value.name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name
#   address_space       = each.value.cidr

#   dynamic "subnet" {
#     for_each = each.value.subnet != null ? each.value.subnet : {}
#     content {
#       name             = subnet.value.name
#       address_prefixes = subnet.value.cidr
#     }
#   }
# }




resource "azurerm_virtual_network" "networking" {
  for_each                = var.vnets
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  address_space           = each.value.address_space
  dns_servers             = lookup(each.value, "dns_servers", null)
  bgp_community           = lookup(each.value, "bgp_community", null)
  edge_zone               = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes = lookup(each.value, "flow_timeout_in_minutes", null)
  tags                    = lookup(each.value, "tags", {})

  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "ddos_protection_plan", null) != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = lookup(ddos_protection_plan.value, "enable", true)
    }
  }
  dynamic "subnet" {
    for_each = lookup(each.value, "subnets", [])
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      service_endpoints                             = lookup(subnet.value, "service_endpoints", null)
      service_endpoint_policy_ids                   = lookup(subnet.value, "service_endpoint_policy_ids", null)
      private_link_service_network_policies_enabled = lookup(subnet.value, "private_link_service_network_policies_enabled", null)

      dynamic "delegation" {
      
        # for_each = lookup(subnet.value, "delegations", [])
        for_each = try({ for k, v in subnet.value.delegations : k => v if v != null }, {})

     
 

        content {
          name = delegation.value.name

          service_delegation {
            name    = delegation.value.service_delegation.name
            actions = delegation.value.service_delegation.actions
          }
        }
      }
    }
  }
}
