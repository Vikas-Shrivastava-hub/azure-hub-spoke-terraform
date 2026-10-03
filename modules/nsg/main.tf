resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.value.name
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  dynamic "security_rule" {
    for_each = each.value.security_rule != null ? each.value.security_rule : {}
    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_port_range            = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges           = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_ranges      = lookup(security_rule.value, "destination_port_ranges", null)
      destination_port_range       = lookup(security_rule.value, "destination_port_range", null)
      source_address_prefix        = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes      = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefixes = lookup(security_rule.value, "destination_address_prefixes", null)
      destination_address_prefix   = lookup(security_rule.value, "destination_address_prefix", null)
    }

  }
}
