# resource "azurerm_network_security_group" "nsg-block" {
#   for_each            = var.nsg
#   name                = each.value.name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   dynamic "security_rule" {
#     for_each = each.value.security_rule != null ? each.value.security_rule : {}
#     content {
#       name                       = security_rule.value.name
#       priority                   = security_rule.value.priority
#       direction                  = security_rule.value.direction
#       access                     = security_rule.value.access
#       protocol                   = security_rule.value.protocol
#       source_port_range          = security_rule.value.source_port_range
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = security_rule.value.source_address_prefix
#       destination_address_prefix = security_rule.value.destination_address_prefix
#     }
#   }


#   tags = {
#     environment = "Production"
#   }
# }



resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg

  name                = each.value.name
  location            = lookup(each.value, "location", {})
  resource_group_name = lookup(each.value, "resource_group_name", {})
  tags                = lookup(each.value, "tags", {})

  dynamic "security_rule" {
    for_each = try({ for rule in each.value.security_rule : rule.name => rule }, {})

    content {
      name                       = lookup(security_rule.value, "name", "default-rule")
      priority                   = lookup(security_rule.value, "priority", 100)
      direction                  = lookup(security_rule.value, "direction", "Inbound")
      access                     = lookup(security_rule.value, "access", "Allow")
      protocol                   = lookup(security_rule.value, "protocol", "*")
      source_port_range          = lookup(security_rule.value, "source_port_range", "*")
      destination_port_range     = lookup(security_rule.value, "destination_port_range", "*")
      source_address_prefix      = lookup(security_rule.value, "source_address_prefix", "*")
      destination_address_prefix = lookup(security_rule.value, "destination_address_prefix", "*")
      description                = lookup(security_rule.value, "description", "Managed by Terraform")
    }
  }
}
