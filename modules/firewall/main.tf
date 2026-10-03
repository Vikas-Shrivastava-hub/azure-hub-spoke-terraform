resource "azurerm_firewall" "firewall" {
  for_each            = var.firewall
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  firewall_policy_id  = var.firewall_policy_id
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration != null ? [each.value.ip_configuration] : []
    content {
      name                 = ip_configuration.value.name
      subnet_id            = var.ip_subnet_id
      public_ip_address_id = var.ip_public_ip_address_id
    }
  }
  dns_servers       = lookup(each.value, "dns_servers", [])
  dns_proxy_enabled = lookup(each.value, "dns_proxy_enabled", null)
  private_ip_ranges = lookup(each.value, "private_ip_ranges", [])
  dynamic "management_ip_configuration" {
    for_each = each.value.management_ip_configuration != null ? [each.value.management_ip_configuration] : []
    content {
      name                 = management_ip_configuration.value.name
      subnet_id            = var.manage_subnet_id
      public_ip_address_id = var.manage_public_ip_id
    }
  }
  threat_intel_mode = lookup(each.value, "threat_intel_mode", null)
  dynamic "virtual_hub" {
    for_each = each.value.virtual_hub != null ? [each.value.virtual_hub] : []
    content {
      virtual_hub_id  = data.azurerm_virtual_network.vnet[each.key].id
      public_ip_count = lookup(virtual_hub.value, "public_ip_count", null)
    }
  }
  zones = lookup(each.value, "zones", [])

}
