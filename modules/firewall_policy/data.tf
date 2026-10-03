data "azurerm_resource_group" "rg" {
  for_each = var.firewall_policy
  name     = each.value.rg_name

}
