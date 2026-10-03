resource "azurerm_firewall_policy_rule_collection_group" "collection_group" {
  for_each = var.rule_collection

  name               = each.value.name
  firewall_policy_id = var.firewall_policy_id
  priority           = each.value.priority

  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collection != null ? each.value.application_rule_collection : {}

    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = application_rule_collection.value.rule

        content {
          name                  = rule.value.name
          source_addresses      = lookup(rule.value, "source_addresses", null)
          source_ip_groups      = lookup(rule.value, "source_ip_groups", null)
          destination_fqdns     = lookup(rule.value, "destination_fqdns", null)
          destination_fqdn_tags = lookup(rule.value, "destination_fqdn_tags", null)
          terminate_tls         = lookup(rule.value, "terminate_tls", false)

          dynamic "protocols" {
            for_each = rule.value.protocols

            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collection != null ? each.value.network_rule_collection : {}

    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = network_rule_collection.value.rule

        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = lookup(rule.value, "source_addresses", null)
          source_ip_groups      = lookup(rule.value, "source_ip_groups", null)
          destination_addresses = lookup(rule.value, "destination_addresses", null)
          destination_ip_groups = lookup(rule.value, "destination_ip_groups", null)
          destination_fqdns     = lookup(rule.value, "destination_fqdns", null)
          destination_ports     = rule.value.destination_ports
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = each.value.nat_rule_collection != null ? each.value.nat_rule_collection : {}

    content {
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = nat_rule_collection.value.rule

        content {
          name                = rule.value.name
          protocols           = rule.value.protocols
          source_addresses    = lookup(rule.value, "source_addresses", null)
          source_ip_groups    = lookup(rule.value, "source_ip_groups", null)
          destination_address = rule.value.destination_address
          destination_ports   = rule.value.destination_ports
          translated_address  = lookup(rule.value, "translated_address", null)
          translated_fqdn     = lookup(rule.value, "translated_fqdn", null)
          translated_port     = rule.value.translated_port
        }
      }
    }
  }
}
