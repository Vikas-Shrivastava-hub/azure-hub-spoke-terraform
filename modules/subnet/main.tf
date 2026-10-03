resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = data.azurerm_resource_group.rg[each.key].name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.address_prefixes
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.service_name
        actions = lookup(delegation.value.service_delegation, "actions", [])
      }
    }
  }
  default_outbound_access_enabled = lookup(each.value, "default_outbound_access_enabled", null)
  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? [each.value.ip_address_pool] : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number
    }
  }
  private_endpoint_network_policies             = lookup(each.value, "private_endpoint_network_policies", null)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)
  sharing_scope                                 = lookup(each.value, "sharing_scope", null)
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", [])

}
