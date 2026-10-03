resource "azurerm_public_ip" "public_ip" {
  for_each                = var.pip
  name                    = each.value.name
  resource_group_name     = data.azurerm_resource_group.rg[each.key].name
  location                = data.azurerm_resource_group.rg[each.key].location
  allocation_method       = each.value.allocation_method
  zones                   = lookup(each.value, "zones", null)
  ddos_protection_mode    = lookup(each.value, "ddos_protection_mode", null)
  ddos_protection_plan_id = lookup(each.value, "ddos_protection_plan_id", null)
  domain_name_label       = lookup(each.value, "domain_name_label", null)
  domain_name_label_scope = lookup(each.value, "domain_name_label_scope", null)
  edge_zone               = lookup(each.value, "edge_zone", null)
  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", null)
  ip_version              = lookup(each.value, "ip_version", null)
  public_ip_prefix_id     = lookup(each.value, "public_ip_prefix_id", null)
  reverse_fqdn            = lookup(each.value, "reverse_fqdn", null)
  sku                     = lookup(each.value, "sku", null)
  sku_tier                = lookup(each.value, "sku_tier", null)
  tags                    = lookup(each.value, "tags", {})
  ip_tags                 = lookup(each.value, "ip_tags", {})
}
